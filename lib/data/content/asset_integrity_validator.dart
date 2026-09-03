import '../../core/constants/app_assets.dart';

class AssetIntegrityReport {
  const AssetIntegrityReport(this.errors);

  final List<String> errors;

  bool get isValid => errors.isEmpty;

  void throwIfInvalid() {
    if (!isValid) throw AssetIntegrityException(errors);
  }
}

class AssetIntegrityException implements Exception {
  const AssetIntegrityException(this.errors);

  final List<String> errors;

  @override
  String toString() =>
      'Asset integrity validation failed:\n${errors.join('\n')}';
}

class AssetIntegrityValidator {
  const AssetIntegrityValidator();

  AssetIntegrityReport validate({
    required Iterable<String> readingAudioKeys,
    required Iterable<String> vocabularyAudioKeys,
    required Iterable<String> glossaryAudioKeys,
    required Iterable<String?> imageKeys,
  }) {
    final errors = <String>[];

    _validateExactKeys(
      category: 'reading',
      contentKeys: readingAudioKeys,
      registeredAssets: AppAssets.readingAudio,
      expectedCount: 5,
      errors: errors,
    );
    _validateExactKeys(
      category: 'vocabulary',
      contentKeys: vocabularyAudioKeys,
      registeredAssets: AppAssets.vocabularyAudio,
      expectedCount: 15,
      errors: errors,
    );
    _validateExactKeys(
      category: 'glossary',
      contentKeys: glossaryAudioKeys,
      registeredAssets: AppAssets.glossaryAudio,
      expectedCount: 26,
      errors: errors,
    );

    for (final imageKey in imageKeys.whereType<String>()) {
      if (!AppAssets.moduleArt.containsKey(imageKey)) {
        errors.add('Unknown image key: $imageKey.');
      }
    }

    final paths = AppAssets.requiredAudioPaths.toList();
    if (paths.toSet().length != paths.length) {
      errors.add('Audio registry contains duplicate destination paths.');
    }

    return AssetIntegrityReport(List.unmodifiable(errors));
  }

  void _validateExactKeys({
    required String category,
    required Iterable<String> contentKeys,
    required Map<String, String> registeredAssets,
    required int expectedCount,
    required List<String> errors,
  }) {
    final keys = contentKeys.toSet();
    if (keys.length != expectedCount) {
      errors.add('Expected $expectedCount unique $category audio keys.');
    }
    if (registeredAssets.length != expectedCount ||
        !registeredAssets.keys.toSet().containsAll(keys) ||
        !keys.containsAll(registeredAssets.keys)) {
      errors.add(
        '$category audio registry does not exactly match content keys.',
      );
    }
  }
}
