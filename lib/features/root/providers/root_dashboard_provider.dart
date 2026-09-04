import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_providers.dart';
import '../../../domain/models/learning_models.dart';
import '../../../domain/models/root_module.dart';

class RootDashboardNotifier extends StateNotifier<RootDashboardState> {
  RootDashboardNotifier(this._ref) : super(_emptyDashboard) {
    _load();
  }

  final Ref _ref;

  static const _emptyDashboard = RootDashboardState(
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

  Future<void> refresh() => _load();

  Future<void> _load() async {
    final db = _ref.read(appDatabaseProvider);
    final repository = _ref.read(attemptRepositoryProvider);
    final rows = await db.select(db.moduleProgress).get();
    final progress = <int, RootModuleProgress>{};
    for (var moduleId = 1; moduleId <= 3; moduleId++) {
      final row = rows.where((item) => item.moduleId == moduleId).firstOrNull;
      final latest = await repository.getLatestScore(moduleId);
      final best = await repository.getBestScore(moduleId);
      final hasCompletedAttempt = (await repository.getCompletedAttempts(
        moduleId,
      )).isNotEmpty;
      progress[moduleId] = RootModuleProgress(
        moduleId: moduleId,
        percent: row?.progressPercent ?? 0,
        status: switch (row?.status) {
          'in_progress' => ModuleStatus.inProgress,
          'completed' => ModuleStatus.completed,
          _ => ModuleStatus.notStarted,
        },
        latestScore: latest?.round(),
        bestScore: best?.round(),
        hasCompletedAttempt: hasCompletedAttempt,
      );
    }
    final activeRows =
        rows.where((item) => item.status == 'in_progress').toList()
          ..sort((a, b) {
            final updated = b.updatedAt.compareTo(a.updatedAt);
            if (updated != 0) return updated;
            return b.moduleId.compareTo(a.moduleId);
          });
    final active = activeRows.firstOrNull;
    if (!mounted) return;
    state = RootDashboardState(
      moduleProgress: progress,
      resume: active == null
          ? null
          : RootResumeState(
              moduleId: active.moduleId,
              stageLabel: active.currentStage ?? 'Continue learning',
              percent: active.progressPercent,
            ),
    );
  }
}

final rootDashboardProvider =
    StateNotifierProvider<RootDashboardNotifier, RootDashboardState>(
      (ref) => RootDashboardNotifier(ref),
    );
