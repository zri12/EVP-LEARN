import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/content/module_content_data_source.dart';
import '../../../data/repositories/module_content_repository.dart';
import '../../../domain/models/module_content.dart';

final moduleContentRepositoryProvider = Provider<ModuleContentRepository>((
  ref,
) {
  return LocalModuleContentRepository(AssetModuleContentDataSource());
});

final learningModuleProvider =
    FutureProvider.family<LearningModuleContent?, String>(
      (ref, moduleId) =>
          ref.watch(moduleContentRepositoryProvider).getModuleById(moduleId),
    );
