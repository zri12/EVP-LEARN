import 'package:evp_learn/data/content/module_content_data_source.dart';
import 'package:evp_learn/data/repositories/module_content_repository.dart';
import 'package:evp_learn/domain/models/module_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final dataSource = AssetModuleContentDataSource();

  test(
    'all bundled module JSON documents load with canonical metadata',
    () async {
      final documents = await dataSource.loadAll();

      expect(documents, hasLength(3));
      expect(
        documents.map((document) => document.module.metadata.id),
        orderedEquals(['module_1', 'module_2', 'module_3']),
      );
      expect(
        documents.every(
          (document) =>
              document.schemaVersion == 1 &&
              document.contentVersion == 1 &&
              document.academicSource ==
                  'UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx',
        ),
        isTrue,
      );
    },
  );

  test('repository resolves modules and readings by stable IDs', () async {
    final repository = LocalModuleContentRepository(dataSource);

    final module = await repository.getModuleById('module_2');
    final jacket = await repository.getReading('module_2', 'm2_reading_03');

    expect(module?.metadata.number, 2);
    expect(jacket?.title, 'Vintage Leather Biker Jacket');
    expect(await repository.getModuleById('module_404'), isNull);
    expect(await repository.getReading('module_2', 'missing'), isNull);
  });

  test('prototype-derived content remains explicitly marked', () async {
    final modules = (await dataSource.loadAll()).map(
      (document) => document.module,
    );

    for (final module in modules) {
      expect(
        module.objectives.map((objective) => objective.contentStatus).toSet(),
        equals({ContentStatus.prototypeDerived}),
      );
      expect(module.pretest.contentStatus, ContentStatus.prototypeDerived);
      expect(module.posttest.contentStatus, ContentStatus.prototypeDerived);
    }
  });
}
