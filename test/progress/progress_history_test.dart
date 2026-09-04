import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:evp_learn/data/database/app_database.dart';
import 'package:evp_learn/data/providers/database_providers.dart';
import 'package:evp_learn/data/repositories/persistence_repository.dart';
import 'package:evp_learn/features/progress/providers/progress_history_provider.dart';
import 'package:evp_learn/features/progress/presentation/progress_page.dart';
import 'package:evp_learn/app/theme/app_theme.dart';
import 'package:evp_learn/l10n/app_localizations.dart';

void main() {
  late AppDatabase database;
  late AttemptRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = AttemptRepository(database);
  });

  tearDown(() => database.close());

  test(
    'snapshot exposes completed attempts newest-first and excludes active',
    () async {
      final first = await _complete(
        repository,
        1,
        pre: 30,
        post: 80,
        practiceScores: [3, 3, 4],
      );
      final retry = await repository.retryModule(1);
      expect(retry.isInProgress, isTrue);

      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
      );
      addTearDown(container.dispose);
      final snapshot = await container.read(
        moduleProgressSnapshotProvider(1).future,
      );

      expect(snapshot.completedAttempts, hasLength(1));
      expect(snapshot.completedAttempts.single.id, first.id);
      expect(snapshot.activeAttempt?.id, retry.id);
      expect(snapshot.latestScore, 80);
      expect(snapshot.bestScore, 80);
    },
  );

  test('attempt detail lookup returns null for unknown id', () async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(attemptDetailProvider('missing').future),
      isNull,
    );
  });

  test('latest and best remain distinct and history is newest-first', () async {
    final first = await _complete(
      repository,
      1,
      pre: 40,
      post: 70,
      practiceScores: [3, 3, 4],
    );
    await repository.retryModule(1);
    final second = await _complete(
      repository,
      1,
      pre: 50,
      post: 70,
      practiceScores: [0, 0, 0],
    );
    await repository.retryModule(1);
    final third = await _complete(
      repository,
      1,
      pre: 60,
      post: 90,
      practiceScores: [6, 7, 7],
    );
    final attempts = await repository.getCompletedAttempts(1);
    expect(attempts.map((a) => a.id), [third.id, second.id, first.id]);
    expect(attempts.first.finalScore, 90);
    expect(attempts.first.attemptNumber, 3);
    expect(await repository.getLatestScore(1), 90);
    expect(await repository.getBestScore(1), 90);
  });

  test(
    'failed completion, gains, and module isolation use persisted values',
    () async {
      final failed = await _complete(
        repository,
        1,
        pre: 80,
        post: 70,
        practiceScores: [3, 3, 3],
        weighted: 60,
      );
      final m2 = await _complete(
        repository,
        2,
        pre: 20,
        post: 60,
        practiceScores: [0, 0, 0],
        weighted: 60,
      );
      expect(failed.isCompleted, isTrue);
      expect(failed.passed, isFalse);
      expect(failed.finalScore, 69);
      expect(failed.learningGain, -10);
      expect(m2.moduleId, 2);
      expect(
        (await repository.getCompletedAttempts(1)).map((a) => a.moduleId),
        [1],
      );
      expect(
        (await repository.getCompletedAttempts(2)).map((a) => a.moduleId),
        [2],
      );
    },
  );

  testWidgets('module detail presents persisted latest, best, and order', (
    tester,
  ) async {
    final first = await _complete(
      repository,
      1,
      pre: 40,
      post: 80,
      practiceScores: [3, 3, 4],
    );
    await repository.retryModule(1);
    final second = await _complete(
      repository,
      1,
      pre: 50,
      post: 70,
      practiceScores: [0, 0, 0],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ModuleProgressDetailPage(moduleId: '1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('70/100'), findsAtLeastNWidgets(2));
    expect(find.text('80/100'), findsNWidgets(2));
    expect(find.text('Attempt 2'), findsOneWidget);
    expect(find.text('Attempt 1'), findsOneWidget);
    expect(find.byKey(Key('history-attempt-${second.id}')), findsOneWidget);
    expect(find.byKey(Key('history-attempt-${first.id}')), findsOneWidget);
  });
}

Future<LearningAttemptRecord> _complete(
  AttemptRepository repository,
  int moduleId, {
  required double pre,
  required double post,
  required List<int> practiceScores,
  double weighted = 70,
}) async {
  final attempt = await repository.startAttempt(moduleId);
  await repository.submitAssessment(
    attemptId: attempt.id,
    type: 'pretest',
    questionOrder: List.generate(10, (index) => 'pre$index'),
    answers: const {},
    correctCount: pre.round() ~/ 10,
    totalQuestions: 10,
    rawScore: pre,
  );
  for (var index = 0; index < 3; index++) {
    await repository.savePracticeResult(
      attemptId: attempt.id,
      activityIndex: index,
      activityType: index == 0 ? 'match' : 'sequence',
      correctItems: practiceScores[index],
      totalItems: 10,
      score: practiceScores[index],
    );
  }
  await repository.submitAssessment(
    attemptId: attempt.id,
    type: 'posttest',
    questionOrder: List.generate(10, (index) => 'post$index'),
    answers: const {},
    correctCount: post.round() ~/ 10,
    totalQuestions: 10,
    rawScore: post,
    weightedScore: weighted,
  );
  return repository.finalizeAttempt(attempt.id);
}
