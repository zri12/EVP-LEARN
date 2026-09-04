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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      // Schema upgrades must be additive and explicit. Never reset learner data.
      if (from < 2) {
        await migrator.addColumn(
          learningAttempts,
          learningAttempts.contentVersion,
        );
        await migrator.addColumn(
          learningAttempts,
          learningAttempts.currentStage,
        );
        await migrator.addColumn(
          learningAttempts,
          learningAttempts.currentSubIndex,
        );
        await migrator.addColumn(
          learningAttempts,
          learningAttempts.currentReadingId,
        );
        await migrator.addColumn(
          learningAttempts,
          learningAttempts.lastRouteKey,
        );
        await migrator.addColumn(
          assessmentSessions,
          assessmentSessions.questionOrderJson,
        );
        await migrator.addColumn(
          assessmentSessions,
          assessmentSessions.currentQuestionIndex,
        );
        await migrator.addColumn(
          practiceActivityResults,
          practiceActivityResults.draftJson,
        );
      }
    },
  );
}
