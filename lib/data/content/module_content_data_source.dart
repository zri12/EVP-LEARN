import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/models/module_content.dart';

abstract interface class ModuleContentDataSource {
  Future<List<ContentDocument>> loadAll();
}

class AssetModuleContentDataSource implements ModuleContentDataSource {
  AssetModuleContentDataSource({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  static const moduleAssetPaths = <String>[
    'assets/data/modules/module_1.json',
    'assets/data/modules/module_2.json',
    'assets/data/modules/module_3.json',
  ];

  final AssetBundle _bundle;

  @override
  Future<List<ContentDocument>> loadAll() async {
    final documents = await Future.wait(
      moduleAssetPaths.map((path) => _loadDocument(path)),
    );
    return List.unmodifiable(documents);
  }

  Future<ContentDocument> _loadDocument(String path) async {
    try {
      final rawJson = await _bundle.loadString(path, cache: false);
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Content document root must be an object.');
      }
      return ContentDocument.fromJson(decoded);
    } on FormatException catch (error) {
      throw ModuleContentLoadException(path, error.message);
    } on Object catch (error) {
      throw ModuleContentLoadException(path, '$error');
    }
  }
}

class ModuleContentLoadException implements Exception {
  const ModuleContentLoadException(this.assetPath, this.message);

  final String assetPath;
  final String message;

  @override
  String toString() => 'ModuleContentLoadException($assetPath): $message';
}
