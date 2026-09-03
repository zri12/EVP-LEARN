import '../../domain/models/module_content.dart';
import '../content/module_content_data_source.dart';

abstract interface class ModuleContentRepository {
  Future<List<LearningModuleContent>> getAllModules();
  Future<LearningModuleContent?> getModuleById(String moduleId);
  Future<ReadingContent?> getReading(String moduleId, String readingId);
}

class LocalModuleContentRepository implements ModuleContentRepository {
  LocalModuleContentRepository(this._dataSource);

  final ModuleContentDataSource _dataSource;
  List<LearningModuleContent>? _cache;

  @override
  Future<List<LearningModuleContent>> getAllModules() async {
    final cached = _cache;
    if (cached != null) return cached;

    final modules = (await _dataSource.loadAll())
        .map((document) => document.module)
        .toList(growable: false);
    _cache = List.unmodifiable(modules);
    return _cache!;
  }

  @override
  Future<LearningModuleContent?> getModuleById(String moduleId) async {
    final modules = await getAllModules();
    for (final module in modules) {
      if (module.metadata.id == moduleId) return module;
    }
    return null;
  }

  @override
  Future<ReadingContent?> getReading(String moduleId, String readingId) async {
    final module = await getModuleById(moduleId);
    if (module == null) return null;
    for (final reading in module.readings) {
      if (reading.id == readingId) return reading;
    }
    return null;
  }
}
