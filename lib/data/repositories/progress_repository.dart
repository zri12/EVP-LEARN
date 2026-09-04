import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'persistence_repository.dart';

/// Read/write facade for the one-row-per-module progress table. Keeping this
/// facade separate lets root screens avoid issuing raw Drift queries.
class ProgressRepository {
  ProgressRepository(this.db, [AttemptRepository? attempts])
    : _attempts = attempts ?? AttemptRepository(db);

  final AppDatabase db;
  final AttemptRepository _attempts;

  Future<List<ModuleProgressData>> getAllModuleProgress() =>
      db.select(db.moduleProgress).get();

  Future<ModuleProgressData?> getModuleProgress(int moduleId) => (db.select(
    db.moduleProgress,
  )..where((row) => row.moduleId.equals(moduleId))).getSingleOrNull();

  Future<void> updateMilestone(
    String attemptId,
    String stage, {
    int? subIndex,
    String? readingId,
    String? routeKey,
    int? progressPercent,
  }) => _attempts.updateStage(
    attemptId,
    stage,
    subIndex: subIndex,
    readingId: readingId,
    routeKey: routeKey,
    progressPercent: progressPercent,
  );

  Future<ModuleProgressData?> getResumeTarget() async {
    final rows =
        await (db.select(db.moduleProgress)
              ..where((row) => row.status.equals('in_progress'))
              ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)])
              ..limit(1))
            .get();
    return rows.firstOrNull;
  }
}
