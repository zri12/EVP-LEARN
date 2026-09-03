import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/learning_models.dart';
import '../../../domain/models/root_module.dart';

/// A deliberately honest empty state until the persistence workflow is wired.
/// Future repositories replace this provider without changing root-screen UI.
final rootDashboardProvider = Provider<RootDashboardState>((ref) {
  return const RootDashboardState(
    moduleProgress: {
      1: RootModuleProgress(
        moduleId: 1,
        percent: 0,
        status: ModuleStatus.notStarted,
      ),
      2: RootModuleProgress(
        moduleId: 2,
        percent: 0,
        status: ModuleStatus.notStarted,
      ),
      3: RootModuleProgress(
        moduleId: 3,
        percent: 0,
        status: ModuleStatus.notStarted,
      ),
    },
  );
});
