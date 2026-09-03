import 'package:evp_learn/data/content/content_validator.dart';
import 'package:evp_learn/data/content/module_content_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final dataSource = AssetModuleContentDataSource();
  final validator = ContentValidator();

  test('complete content inventory passes all integrity checks', () async {
    final report = validator.validate(await dataSource.loadAll());

    expect(report.errors, isEmpty, reason: report.errors.join('\n'));
    expect(report.isValid, isTrue);
  });

  test(
    'formal glossary retains required canonical terms and audio keys',
    () async {
      final modules = (await dataSource.loadAll()).map(
        (document) => document.module,
      );
      final module2 = modules.firstWhere(
        (module) => module.metadata.id == 'module_2',
      );
      final module3 = modules.firstWhere(
        (module) => module.metadata.id == 'module_3',
      );
      final jacket = module2.readings.firstWhere(
        (reading) => reading.id == 'm2_reading_03',
      );
      final glossary = modules.expand(
        (module) => module.readings.expand((reading) => reading.glossary),
      );

      expect(
        jacket.glossary.map((item) => item.term),
        orderedEquals([
          'Premium',
          'Asymmetrical',
          'Adjustable',
          'Eye-catching',
          'Centerpiece',
        ]),
      );
      expect(
        jacket.glossary.map((item) => item.term),
        isNot(contains('Genuine')),
      );
      expect(
        module3.readings.single.glossary.map((item) => item.term),
        orderedEquals([
          'Greet',
          'Scan',
          'Verify',
          'Payment method',
          'Insert',
          'Attach',
        ]),
      );
      expect(
        glossary.map((item) => item.audioKey),
        containsAll(['premium', 'revolutionary']),
      );

      final adjustable = glossary
          .where((item) => item.term == 'Adjustable')
          .toList();
      expect(adjustable, hasLength(2));
      expect(adjustable.map((item) => item.audioKey).toSet(), {'adjustable'});
    },
  );

  test(
    'Flat-packing source wording and subtitle discrepancy remain explicit',
    () async {
      final modules = (await dataSource.loadAll()).map(
        (document) => document.module,
      );
      final module1 = modules.firstWhere(
        (module) => module.metadata.id == 'module_1',
      );
      final flatPacking = module1.readings.single.glossary.firstWhere(
        (item) => item.term == 'Flat-packing',
      );

      expect(flatPacking.meaning, 'Pengemasan barang secara pipih/dUS');
      expect(module1.metadata.subtitle, 'Inspirational Business Stories');
      expect(module1.metadata.subtitleStatus.jsonValue, 'pending_validation');
    },
  );
}
