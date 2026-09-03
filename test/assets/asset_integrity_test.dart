import 'dart:io';

import 'package:evp_learn/core/constants/app_assets.dart';
import 'package:evp_learn/data/content/asset_integrity_validator.dart';
import 'package:evp_learn/data/content/audio_asset_resolver.dart';
import 'package:evp_learn/data/content/module_content_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final dataSource = AssetModuleContentDataSource();
  const resolver = AudioAssetResolver();
  const validator = AssetIntegrityValidator();

  test(
    'content audio keys resolve to the complete required offline registry',
    () async {
      final modules = (await dataSource.loadAll()).map(
        (document) => document.module,
      );
      final readings = modules.expand((module) => module.readings).toList();
      final vocabulary = modules.expand((module) => module.vocabulary).toList();
      final glossary = readings.expand((reading) => reading.glossary).toList();

      final report = validator.validate(
        readingAudioKeys: readings.map((reading) => reading.readingAudioKey),
        vocabularyAudioKeys: vocabulary.map((item) => item.audioKey),
        glossaryAudioKeys: glossary.map((item) => item.audioKey),
        imageKeys: [
          ...readings.map((reading) => reading.imageKey),
          ...modules.expand(
            (module) => [
              ...module.pretest.questions.map((question) => question.imageKey),
              ...module.posttest.questions.map((question) => question.imageKey),
            ],
          ),
        ],
      );

      expect(report.errors, isEmpty, reason: report.errors.join('\n'));
      expect(readings, hasLength(5));
      expect(vocabulary, hasLength(15));
      expect(glossary.map((item) => item.audioKey).toSet(), hasLength(26));

      for (final reading in readings) {
        expect(
          resolver.resolveReading(reading.readingAudioKey),
          startsWith('assets/audio/reading/'),
        );
      }
      for (final item in vocabulary) {
        expect(
          resolver.resolveVocabulary(item.audioKey),
          startsWith('assets/audio/vocabulary/'),
        );
      }
      for (final item in glossary) {
        expect(
          resolver.resolveGlossary(item.audioKey),
          startsWith('assets/audio/glossary/'),
        );
      }
    },
  );

  test('bundled required asset files exist and are non-empty', () {
    final paths = [
      ...AppAssets.requiredImagePaths,
      ...AppAssets.requiredAudioPaths,
    ];

    expect(paths, hasLength(50));
    for (final path in paths) {
      final file = File(path);
      expect(
        file.existsSync(),
        isTrue,
        reason: 'Missing required asset: $path',
      );
      expect(file.lengthSync(), greaterThan(0), reason: 'Empty asset: $path');
    }
  });

  test('unknown audio keys fail in a controlled way', () {
    expect(
      () => resolver.resolveGlossary('not-a-canonical-term'),
      throwsA(isA<UnknownAudioAssetKeyException>()),
    );
  });
}
