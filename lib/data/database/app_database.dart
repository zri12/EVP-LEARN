import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/assessment_sessions.dart';
import 'tables/learning_attempts.dart';
import 'tables/module_baselines.dart';
import 'tables/module_progress.dart';
import 'tables/practice_activity_results.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    ModuleProgress,
    LearningAttempts,
    PracticeActivityResults,
    AssessmentSessions,
    ModuleBaselines,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'evp_learn'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      // Schema upgrades must be additive and explicit. Never reset learner data.
    },
  );
}
