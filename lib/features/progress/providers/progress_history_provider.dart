import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_providers.dart';
import '../../../data/repositories/persistence_repository.dart';

class ModuleProgressSnapshot {
  const ModuleProgressSnapshot({
    required this.moduleId,
    required this.completedAttempts,
    this.activeAttempt,
  });

  final int moduleId;
  final List<LearningAttemptRecord> completedAttempts;
  final LearningAttemptRecord? activeAttempt;

  LearningAttemptRecord? get latestAttempt =>
      completedAttempts.isEmpty ? null : completedAttempts.first;

  double? get latestScore => latestAttempt?.finalScore;

  double? get bestScore {
    final scores = completedAttempts
        .map((attempt) => attempt.finalScore)
        .whereType<double>();
    if (scores.isEmpty) return null;
    return scores.reduce((a, b) => a > b ? a : b);
  }

  bool get hasHistory => completedAttempts.isNotEmpty;
}

final moduleProgressSnapshotProvider = FutureProvider.autoDispose
    .family<ModuleProgressSnapshot, int>((ref, moduleId) async {
      if (moduleId < 1 || moduleId > 3) {
        throw ArgumentError.value(moduleId, 'moduleId');
      }
      final repository = ref.watch(attemptRepositoryProvider);
      final completed = await repository.getCompletedAttempts(moduleId);
      final active = await repository.getCurrentAttempt(moduleId);
      return ModuleProgressSnapshot(
        moduleId: moduleId,
        completedAttempts: completed,
        activeAttempt: active,
      );
    });

final attemptDetailProvider = FutureProvider.autoDispose
    .family<LearningAttemptRecord?, String>((ref, attemptId) {
      return ref.watch(attemptRepositoryProvider).getAttempt(attemptId);
    });
