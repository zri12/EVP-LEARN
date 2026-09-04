import 'learning_models.dart';

/// Presentation metadata only. Academic content stays out of the root shell.
class RootModule {
  const RootModule({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.assetPath,
  });

  final int id;
  final String title;
  final String subtitle;
  final String assetPath;
}

class RootModuleProgress {
  const RootModuleProgress({
    required this.moduleId,
    required this.percent,
    required this.status,
    this.latestScore,
    this.bestScore,
    this.hasCompletedAttempt = false,
  });

  final int moduleId;
  final int percent;
  final ModuleStatus status;
  final int? latestScore;
  final int? bestScore;

  /// True when the learner has at least one completed attempt, even if a new
  /// retry is currently active for the module.
  final bool hasCompletedAttempt;
}

class RootResumeState {
  const RootResumeState({
    required this.moduleId,
    required this.stageLabel,
    required this.percent,
    this.lastRouteKey,
  });

  final int moduleId;
  final String stageLabel;
  final int percent;

  /// Last persisted learning route, when available, for exact resume.
  final String? lastRouteKey;
}

class RootDashboardState {
  const RootDashboardState({required this.moduleProgress, this.resume});

  final Map<int, RootModuleProgress> moduleProgress;
  final RootResumeState? resume;

  RootModuleProgress progressFor(int moduleId) =>
      moduleProgress[moduleId] ??
      RootModuleProgress(
        moduleId: moduleId,
        percent: 0,
        status: ModuleStatus.notStarted,
      );

  int get overallPercent {
    if (moduleProgress.isEmpty) {
      return 0;
    }
    final total = moduleProgress.values.fold<int>(
      0,
      (sum, progress) => sum + progress.percent,
    );
    return (total / 3).round();
  }

  int get completedModules => moduleProgress.values
      .where(
        (progress) =>
            progress.status == ModuleStatus.completed ||
            progress.hasCompletedAttempt,
      )
      .length;
}
