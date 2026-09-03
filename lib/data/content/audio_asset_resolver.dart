import '../../core/constants/app_assets.dart';

enum AudioAssetCategory { reading, vocabulary, glossary }

class AudioAssetResolver {
  const AudioAssetResolver();

  String resolveReading(String key) =>
      _resolve(AudioAssetCategory.reading, key, AppAssets.readingAudio);

  String resolveVocabulary(String key) =>
      _resolve(AudioAssetCategory.vocabulary, key, AppAssets.vocabularyAudio);

  String resolveGlossary(String key) =>
      _resolve(AudioAssetCategory.glossary, key, AppAssets.glossaryAudio);

  String _resolve(
    AudioAssetCategory category,
    String key,
    Map<String, String> assets,
  ) {
    final path = assets[key];
    if (path != null) return path;
    throw UnknownAudioAssetKeyException(category, key);
  }
}

class UnknownAudioAssetKeyException implements Exception {
  const UnknownAudioAssetKeyException(this.category, this.key);

  final AudioAssetCategory category;
  final String key;

  @override
  String toString() => 'Unknown ${category.name} audio key: $key';
}
