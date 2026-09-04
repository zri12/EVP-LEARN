import 'dart:io';

import 'package:drift/native.dart';
import 'package:evp_learn/data/database/app_database.dart';
import 'package:evp_learn/data/repositories/persistence_repository.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/models/module_content.dart';
import 'package:evp_learn/features/assessment/providers/assessment_session_provider.dart';
import 'package:evp_learn/features/learning/providers/current_attempt_provider.dart';
import 'package:evp_learn/features/practice/providers/practice_session_provider.dart';
import 'package:evp_learn/data/providers/database_providers.dart';
import 'package:evp_learn/features/root/providers/root_dashboard_provider.dart';
import 'package:evp_learn/domain/models/learning_models.dart'
    hide AssessmentType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late AttemptRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = AttemptRepository(database);
  });

  tearDown(() => database.close());

  test('attempt start is stable per module and stage persists', () async {
    final first = await repository.startAttempt(1);
    final same = await repository.startAttempt(1);
    expect(same.id, first.id);
    const stages = [
      PersistedLearningStage.objectives,
      PersistedLearningStage.pretestResult,
      PersistedLearningStage.theory,
      PersistedLearningStage.vocabulary,
      PersistedLearningStage.reading,
      PersistedLearningStage.practice,
      PersistedLearningStage.posttest,
    ];
    for (final stage in stages) {
      await repository.updateStage(
        first.id,
        stage,
        subIndex: stage == PersistedLearningStage.reading ? 1 : null,
        readingId: stage == PersistedLearningStage.reading
            ? 'm1_reading_2'
            : null,
      );
      final loaded = await repository.getCurrentAttempt(1);
      expect(loaded?.id, first.id);
      expect(loaded?.currentStage, stage);
      if (stage == PersistedLearningStage.reading) {
        expect(loaded?.currentSubIndex, 1);
        expect(loaded?.currentReadingId, 'm1_reading_2');
      }
    }
    final loaded = await repository.getCurrentAttempt(1);
    expect(loaded?.currentSubIndex, isNull);
    expect(loaded?.currentReadingId, isNull);
  });

  test(
    'drafts and baseline are durable and finalization is idempotent',
    () async {
      final attempt = await repository.startAttempt(1);
      await repository.saveAssessmentDraft(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['q2', 'q1'],
        answers: const {'q2': 1},
        currentQuestionIndex: 1,
      );
      final draft = await repository.getAssessmentDraft(attempt.id, 'pretest');
      expect(draft?.questionOrder, ['q2', 'q1']);
      expect(draft?.answers['q2'], 1);
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['q2', 'q1'],
        answers: const {'q2': 1, 'q1': 0},
        correctCount: 1,
        totalQuestions: 2,
        rawScore: 50,
      );
      await repository.savePracticeDraft(
        attemptId: attempt.id,
        activityIndex: 0,
        activityType: 'match',
        pairings: const {'s1': 't1'},
      );
      expect(
        (await repository.getPracticeDraft(attempt.id, 0))?.pairings['s1'],
        't1',
      );
      for (var i = 0; i < 3; i++) {
        await repository.savePracticeResult(
          attemptId: attempt.id,
          activityIndex: i,
          activityType: i == 0 ? 'match' : 'sequence',
          correctItems: 1,
          totalItems: 1,
          score: 10,
        );
      }
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'posttest',
        questionOrder: const ['p1'],
        answers: const {'p1': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 100,
        weightedScore: 70,
      );
      final completed = await repository.finalizeAttempt(attempt.id);
      final repeated = await repository.finalizeAttempt(attempt.id);
      expect(completed.status, 'completed');
      expect(completed.finalScore, 100);
      expect(repeated.completedAt, completed.completedAt);
      expect((await repository.getBaseline(1))?.pretestRaw, 50);
      final retry = await repository.retryModule(1);
      expect(retry.id, isNot(attempt.id));
      expect((await repository.getCompletedAttempts(1)).length, 1);
    },
  );

  test('schema v1 rows survive additive v2 migration', () async {
    final file = File(
      '${Directory.systemTemp.path}/evp_phase8_${DateTime.now().microsecondsSinceEpoch}.db',
    );
    addTearDown(() async {
      if (file.existsSync()) await file.delete();
    });
    final old = AppDatabase(NativeDatabase(file));
    await old
        .into(old.learningAttempts)
        .insert(
          LearningAttemptsCompanion.insert(
            id: 'legacy-attempt',
            moduleId: 1,
            attemptNumber: 1,
            status: 'in_progress',
            startedAt: DateTime(2025),
          ),
        );
    for (final column in [
      'content_version',
      'current_stage',
      'current_sub_index',
      'current_reading_id',
      'last_route_key',
    ]) {
      await old.customStatement(
        'ALTER TABLE learning_attempts DROP COLUMN $column',
      );
    }
    await old.customStatement(
      'ALTER TABLE assessment_sessions DROP COLUMN question_order_json',
    );
    await old.customStatement(
      'ALTER TABLE assessment_sessions DROP COLUMN current_question_index',
    );
    await old.customStatement(
      'ALTER TABLE practice_activity_results DROP COLUMN draft_json',
    );
    await old.customStatement('PRAGMA user_version = 1');
    await old.close();
    final upgraded = AppDatabase(NativeDatabase(file));
    addTearDown(upgraded.close);
    final row = await (upgraded.select(
      upgraded.learningAttempts,
    )..where((attempt) => attempt.id.equals('legacy-attempt'))).getSingle();
    expect(upgraded.schemaVersion, 2);
    expect(row.moduleId, 1);
    expect(row.currentStage, PersistedLearningStage.overview);
    final columns = await upgraded
        .customSelect('PRAGMA table_info(learning_attempts)')
        .get();
    expect(
      columns.any((column) => column.read<String>('name') == 'content_version'),
      isTrue,
    );
  });

  test(
    'one active attempt per module and active modules are independent',
    () async {
      final m1 = await repository.startAttempt(1);
      final m1Again = await repository.startAttempt(1);
      final m2 = await repository.startAttempt(2);
      expect(m1Again.id, m1.id);
      expect(m2.id, isNot(m1.id));
      expect((await repository.getCurrentAttempt(1))?.id, m1.id);
      expect((await repository.getCurrentAttempt(2))?.id, m2.id);
    },
  );

  test('completed attempt rejects active-only mutations', () async {
    final completed = await _complete(
      repository,
      pre: 40,
      post: 90,
      practiceScore: 10,
    );
    await repository.updateStage(completed.id, PersistedLearningStage.theory);
    await repository.saveAssessmentDraft(
      attemptId: completed.id,
      type: 'pretest',
      questionOrder: const ['x'],
      answers: const {'x': 0},
      currentQuestionIndex: 0,
    );
    await repository.savePracticeDraft(
      attemptId: completed.id,
      activityIndex: 0,
      activityType: 'match',
      pairings: const {'a': 'b'},
    );
    expect(
      (await repository.getAttempt(completed.id))?.currentStage,
      PersistedLearningStage.result,
    );
    expect((await repository.getPracticeResults(completed.id)).first.score, 10);
  });

  test('baseline is first-only and retry gain uses retry pre-test', () async {
    await _complete(repository, pre: 40, post: 80, practiceScore: 0);
    expect((await repository.getBaseline(1))?.pretestRaw, 40);
    final retry = await repository.retryModule(1);
    await repository.submitAssessment(
      attemptId: retry.id,
      type: 'pretest',
      questionOrder: const ['pre'],
      answers: const {'pre': 0},
      correctCount: 1,
      totalQuestions: 1,
      rawScore: 80,
    );
    for (var i = 0; i < 3; i++) {
      await repository.savePracticeResult(
        attemptId: retry.id,
        activityIndex: i,
        activityType: 'match',
        correctItems: 0,
        totalItems: 1,
        score: 0,
      );
    }
    await repository.submitAssessment(
      attemptId: retry.id,
      type: 'posttest',
      questionOrder: const ['post'],
      answers: const {'post': 0},
      correctCount: 1,
      totalQuestions: 1,
      rawScore: 90,
      weightedScore: 70,
    );
    final result = await repository.finalizeAttempt(retry.id);
    expect(result.learningGain, 10);
    expect((await repository.getBaseline(1))?.pretestRaw, 40);
  });

  test(
    'finalization requires exactly three completed activities and preserves failure completion',
    () async {
      final attempt = await repository.startAttempt(1);
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['pre'],
        answers: const {'pre': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 40,
      );
      await expectLater(
        repository.finalizeAttempt(attempt.id),
        throwsStateError,
      );
      expect((await repository.getAttempt(attempt.id))?.status, 'in_progress');
      for (var i = 0; i < 3; i++) {
        await repository.savePracticeResult(
          attemptId: attempt.id,
          activityIndex: i,
          activityType: 'match',
          correctItems: 1,
          totalItems: 5,
          score: 2,
        );
      }
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'posttest',
        questionOrder: const ['post'],
        answers: const {'post': 0},
        correctCount: 0,
        totalQuestions: 1,
        rawScore: 90,
        weightedScore: 63,
      );
      final failed = await repository.finalizeAttempt(attempt.id);
      expect(failed.status, 'completed');
      expect(failed.finalScore, 69);
      expect(failed.passed, isFalse);
    },
  );

  test(
    'latest and best use completedAt ordering and ignore active retry',
    () async {
      await _complete(repository, pre: 40, post: 80, practiceScore: 10);
      expect(await repository.getLatestScore(1), 100);
      expect(await repository.getBestScore(1), 100);
      final retry = await repository.retryModule(1);
      expect(await repository.getLatestScore(1), 100);
      expect(await repository.getBestScore(1), 100);
      await repository.submitAssessment(
        attemptId: retry.id,
        type: 'pretest',
        questionOrder: const ['pre'],
        answers: const {'pre': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 40,
      );
      for (var i = 0; i < 3; i++) {
        await repository.savePracticeResult(
          attemptId: retry.id,
          activityIndex: i,
          activityType: 'match',
          correctItems: 0,
          totalItems: 1,
          score: 0,
        );
      }
      await repository.submitAssessment(
        attemptId: retry.id,
        type: 'posttest',
        questionOrder: const ['post'],
        answers: const {'post': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 70,
        weightedScore: 70,
      );
      await repository.finalizeAttempt(retry.id);
      expect(await repository.getLatestScore(1), 70);
      expect(await repository.getBestScore(1), 100);
    },
  );

  test(
    'pre-test order, answers, position, and type restore by stable IDs',
    () async {
      final attempt = await repository.startAttempt(1);
      const bank = QuestionBank(
        id: 'audit-pre',
        contentStatus: ContentStatus.prototypeDerived,
        questions: [
          AssessmentQuestion(
            id: 'q01',
            prompt: 'one',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
          AssessmentQuestion(
            id: 'q02',
            prompt: 'two',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
          AssessmentQuestion(
            id: 'q07',
            prompt: 'seven',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
        ],
      );
      await repository.saveAssessmentDraft(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['q07', 'q02', 'q01'],
        answers: const {'q07': 0, 'q01': 0},
        currentQuestionIndex: 1,
      );
      final restored = AssessmentSessionController(
        moduleId: 'module_1',
        type: AssessmentType.pretest,
        questionBank: bank,
        shuffleSeed: 17,
      )..attachPersistence(repository, attempt.id);
      await restored.restoreDraft();
      expect(restored.state.moduleId, 'module_1');
      expect(restored.state.type, AssessmentType.pretest);
      expect(restored.state.questionBank.questions.map((q) => q.id), [
        'q07',
        'q02',
        'q01',
      ]);
      expect(restored.state.answers, {'q07': 0, 'q01': 0});
      expect(restored.state.currentQuestionIndex, 1);
      restored.dispose();
    },
  );

  test(
    'post-test order and answers restore separately from pre-test',
    () async {
      final attempt = await repository.startAttempt(1);
      const bank = QuestionBank(
        id: 'audit-post',
        contentStatus: ContentStatus.prototypeDerived,
        questions: [
          AssessmentQuestion(
            id: 'p1',
            prompt: 'one',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
          AssessmentQuestion(
            id: 'p2',
            prompt: 'two',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
        ],
      );
      await repository.saveAssessmentDraft(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['p1', 'p2'],
        answers: const {'p1': 0},
        currentQuestionIndex: 0,
      );
      await repository.saveAssessmentDraft(
        attemptId: attempt.id,
        type: 'posttest',
        questionOrder: const ['p2', 'p1'],
        answers: const {'p2': 0},
        currentQuestionIndex: 1,
      );
      final post = AssessmentSessionController(
        moduleId: 'module_1',
        type: AssessmentType.posttest,
        questionBank: bank,
        shuffleSeed: 23,
      )..attachPersistence(repository, attempt.id);
      await post.restoreDraft();
      expect(post.state.type, AssessmentType.posttest);
      expect(post.state.questionBank.questions.map((q) => q.id), ['p2', 'p1']);
      expect(post.state.answers, {'p2': 0});
      expect(post.state.currentQuestionIndex, 1);
      post.dispose();
    },
  );

  test(
    'corrupt assessment order is rejected without silent reshuffle',
    () async {
      const bank = QuestionBank(
        id: 'audit-corrupt',
        contentStatus: ContentStatus.prototypeDerived,
        questions: [
          AssessmentQuestion(
            id: 'q1',
            prompt: '1',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
          AssessmentQuestion(
            id: 'q2',
            prompt: '2',
            options: ['a'],
            correctOptionIndex: 0,
            imageKey: null,
            feedback: null,
            contentStatus: ContentStatus.prototypeDerived,
          ),
        ],
      );
      for (final badOrder in [
        const ['q1', 'unknown'],
        const ['q1', 'q1'],
        const ['q1'],
      ]) {
        final attempt = await repository.startAttempt(1);
        await repository.saveAssessmentDraft(
          attemptId: attempt.id,
          type: 'pretest',
          questionOrder: badOrder,
          answers: const {},
          currentQuestionIndex: 0,
        );
        final controller = AssessmentSessionController(
          moduleId: 'module_1',
          type: AssessmentType.pretest,
          questionBank: bank,
          shuffleSeed: 7,
        )..attachPersistence(repository, attempt.id);
        await expectLater(
          controller.restoreDraft(),
          throwsA(isA<AssessmentDraftCorruptionException>()),
        );
        controller.dispose();
        await repository.retryModule(1);
      }
    },
  );

  test(
    'matching and sequence drafts survive a reconstructed practice session',
    () async {
      final attempt = await repository.startAttempt(1);
      final activities = _auditActivities();
      await repository.savePracticeDraft(
        attemptId: attempt.id,
        activityIndex: 0,
        activityType: 'match',
        pairings: const {'sourceA': 'target2', 'sourceB': 'target1'},
      );
      final matching = PracticeSessionController(
        moduleId: 'module_1',
        activities: activities,
      )..attachPersistence(repository, attempt.id);
      await matching.restoreSession();
      expect(matching.state.pairings, {
        'sourceA': 'target2',
        'sourceB': 'target1',
      });
      matching.dispose();

      await repository.savePracticeResult(
        attemptId: attempt.id,
        activityIndex: 0,
        activityType: 'match',
        correctItems: 1,
        totalItems: 2,
        score: 5,
      );
      await repository.savePracticeDraft(
        attemptId: attempt.id,
        activityIndex: 1,
        activityType: 'sequence',
        sequenceOrder: const ['item3', 'item1', 'item2'],
      );
      final sequence = PracticeSessionController(
        moduleId: 'module_1',
        activities: activities,
      )..attachPersistence(repository, attempt.id);
      await sequence.restoreSession();
      expect(sequence.state.currentActivityIndex, 1);
      expect(sequence.state.sequenceOrder, ['item3', 'item1', 'item2']);
      sequence.dispose();
    },
  );

  test(
    'completed practice result is immutable and finalization rejects wrong activity set',
    () async {
      final attempt = await repository.startAttempt(1);
      await repository.savePracticeResult(
        attemptId: attempt.id,
        activityIndex: 0,
        activityType: 'match',
        correctItems: 2,
        totalItems: 2,
        score: 10,
      );
      await repository.savePracticeDraft(
        attemptId: attempt.id,
        activityIndex: 0,
        activityType: 'match',
        pairings: const {'sourceA': 'target1'},
      );
      final unchanged = (await repository.getPracticeResults(
        attempt.id,
      )).single;
      expect(unchanged.score, 10);
      await expectLater(
        repository.finalizeAttempt(attempt.id),
        throwsStateError,
      );
      await repository.savePracticeResult(
        attemptId: attempt.id,
        activityIndex: 1,
        activityType: 'match',
        correctItems: 0,
        totalItems: 1,
        score: 0,
      );
      await expectLater(
        repository.savePracticeResult(
          attemptId: attempt.id,
          activityIndex: 3,
          activityType: 'match',
          correctItems: 0,
          totalItems: 1,
          score: 0,
        ),
        throwsArgumentError,
      );
      // Activity 2 is intentionally missing, so finalization must reject.
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['q'],
        answers: const {'q': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 40,
      );
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'posttest',
        questionOrder: const ['q'],
        answers: const {'q': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 90,
        weightedScore: 70,
      );
      await expectLater(
        repository.finalizeAttempt(attempt.id),
        throwsStateError,
      );
    },
  );

  test(
    'retry double trigger leaves one active attempt and provider reconstructs it',
    () async {
      await _complete(repository, pre: 40, post: 80, practiceScore: 10);
      final retries = await Future.wait([
        repository.retryModule(1),
        repository.retryModule(1),
      ]);
      expect(retries[0].id, retries[1].id);
      expect(
        (await repository.getAttempts(1)).where((a) => a.isInProgress).length,
        1,
      );

      final firstContainer = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
      );
      firstContainer.read(currentAttemptProvider('module_1'));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(
        firstContainer.read(currentAttemptProvider('module_1')).attemptId,
        retries[0].id,
      );
      firstContainer.dispose();
      final secondContainer = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
      );
      addTearDown(secondContainer.dispose);
      secondContainer.read(currentAttemptProvider('module_1'));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(
        secondContainer.read(currentAttemptProvider('module_1')).attemptId,
        retries[0].id,
      );
    },
  );

  test(
    'status, historical completion count, and multi-module Continue are deterministic',
    () async {
      final first = await repository.startAttempt(1);
      await repository.updateStage(first.id, PersistedLearningStage.theory);
      final second = await repository.startAttempt(2);
      await repository.updateStage(
        second.id,
        PersistedLearningStage.reading,
        subIndex: 1,
        readingId: 'm2_reading_2',
      );
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
      );
      addTearDown(container.dispose);
      container.read(rootDashboardProvider);
      await Future<void>.delayed(const Duration(milliseconds: 30));
      final dashboard = container.read(rootDashboardProvider);
      expect(dashboard.progressFor(1).status, ModuleStatus.inProgress);
      expect(dashboard.progressFor(2).status, ModuleStatus.inProgress);
      expect(dashboard.resume?.moduleId, 2);
      expect(dashboard.resume?.stageLabel, PersistedLearningStage.reading);
      expect(dashboard.resume?.percent, 65);
      expect(dashboard.completedModules, 0);

      await _complete(repository, pre: 40, post: 80, practiceScore: 10);
      final retry = await repository.retryModule(1);
      expect(retry.moduleId, 1);
      await container.read(rootDashboardProvider.notifier).refresh();
      final afterRetry = container.read(rootDashboardProvider);
      expect(afterRetry.progressFor(1).status, ModuleStatus.inProgress);
      expect(afterRetry.completedModules, 1);
    },
  );

  test('retry creates fresh independently seeded assessment orders', () async {
    await _complete(repository, pre: 40, post: 80, practiceScore: 10);
    final retry = await repository.retryModule(1);
    expect(await repository.getAssessmentDraft(retry.id, 'pretest'), isNull);
    const bank = QuestionBank(
      id: 'shuffle-audit',
      contentStatus: ContentStatus.prototypeDerived,
      questions: [
        AssessmentQuestion(
          id: 'q1',
          prompt: '1',
          options: ['a'],
          correctOptionIndex: 0,
          imageKey: null,
          feedback: null,
          contentStatus: ContentStatus.prototypeDerived,
        ),
        AssessmentQuestion(
          id: 'q2',
          prompt: '2',
          options: ['a'],
          correctOptionIndex: 0,
          imageKey: null,
          feedback: null,
          contentStatus: ContentStatus.prototypeDerived,
        ),
        AssessmentQuestion(
          id: 'q3',
          prompt: '3',
          options: ['a'],
          correctOptionIndex: 0,
          imageKey: null,
          feedback: null,
          contentStatus: ContentStatus.prototypeDerived,
        ),
        AssessmentQuestion(
          id: 'q4',
          prompt: '4',
          options: ['a'],
          correctOptionIndex: 0,
          imageKey: null,
          feedback: null,
          contentStatus: ContentStatus.prototypeDerived,
        ),
      ],
    );
    final firstOrder = AssessmentSessionController(
      moduleId: 'module_1',
      type: AssessmentType.pretest,
      questionBank: bank,
      shuffleSeed: 11,
    ).state.questionBank.questions.map((q) => q.id).toList();
    final retryOrder = AssessmentSessionController(
      moduleId: 'module_1',
      type: AssessmentType.pretest,
      questionBank: bank,
      shuffleSeed: 12,
    ).state.questionBank.questions.map((q) => q.id).toList();
    expect(retryOrder, isNot(firstOrder));
  });

  test('malformed practice JSON returns a controlled corruption error', () async {
    final attempt = await repository.startAttempt(1);
    await repository.savePracticeDraft(
      attemptId: attempt.id,
      activityIndex: 0,
      activityType: 'match',
      pairings: const {'a': 'b'},
    );
    await database.customStatement(
      "UPDATE practice_activity_results SET draft_json = 'not-json' WHERE attempt_id = '${attempt.id}' AND activity_index = 0",
    );
    await expectLater(
      repository.getPracticeDraft(attempt.id, 0),
      throwsA(isA<PracticeDraftCorruptionException>()),
    );
  });

  test('finalization rejects zero, one, and two practice activities', () async {
    for (var count = 0; count < 3; count++) {
      final attempt = await repository.startAttempt(count + 1);
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'pretest',
        questionOrder: const ['pre'],
        answers: const {'pre': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 40,
      );
      for (var index = 0; index < count; index++) {
        await repository.savePracticeResult(
          attemptId: attempt.id,
          activityIndex: index,
          activityType: 'match',
          correctItems: 0,
          totalItems: 1,
          score: 0,
        );
      }
      await repository.submitAssessment(
        attemptId: attempt.id,
        type: 'posttest',
        questionOrder: const ['post'],
        answers: const {'post': 0},
        correctCount: 1,
        totalQuestions: 1,
        rawScore: 80,
        weightedScore: 56,
      );
      await expectLater(
        repository.finalizeAttempt(attempt.id),
        throwsStateError,
      );
      expect((await repository.getAttempt(attempt.id))?.isInProgress, isTrue);
    }
  });

  test('cross-module finalization guard leaves the attempt active', () async {
    final attempt = await repository.startAttempt(1);
    await expectLater(
      repository.finalizeAttempt(attempt.id, moduleId: 2),
      throwsStateError,
    );
    final unchanged = await repository.getAttempt(attempt.id);
    expect(unchanged?.isInProgress, isTrue);
    expect(unchanged?.completedAt, isNull);
    expect(unchanged?.finalScore, isNull);
  });
}

List<PracticeDefinition> _auditActivities() => [
  const PracticeDefinition(
    id: 'activity_1',
    kind: PracticeKind.match,
    sourceInteraction: 'tap',
    title: 'Match',
    instruction: 'Match',
    contentStatus: ContentStatus.prototypeDerived,
    sourceItems: [
      PracticeItem(id: 'sourceA', label: 'A'),
      PracticeItem(id: 'sourceB', label: 'B'),
    ],
    targetItems: [
      PracticeItem(id: 'target1', label: '1'),
      PracticeItem(id: 'target2', label: '2'),
    ],
    answerMappings: [
      PracticeAnswerMapping(sourceId: 'sourceA', targetId: 'target1'),
      PracticeAnswerMapping(sourceId: 'sourceB', targetId: 'target2'),
    ],
    sequenceItems: [],
    expectedOrder: [],
  ),
  const PracticeDefinition(
    id: 'activity_2',
    kind: PracticeKind.sequence,
    sourceInteraction: 'reorder',
    title: 'Sequence',
    instruction: 'Order',
    contentStatus: ContentStatus.prototypeDerived,
    sourceItems: [],
    targetItems: [],
    answerMappings: [],
    sequenceItems: [
      PracticeItem(id: 'item1', label: '1'),
      PracticeItem(id: 'item2', label: '2'),
      PracticeItem(id: 'item3', label: '3'),
    ],
    expectedOrder: ['item1', 'item2', 'item3'],
  ),
  const PracticeDefinition(
    id: 'activity_3',
    kind: PracticeKind.match,
    sourceInteraction: 'tap',
    title: 'Match 2',
    instruction: 'Match',
    contentStatus: ContentStatus.prototypeDerived,
    sourceItems: [PracticeItem(id: 's3', label: '3')],
    targetItems: [PracticeItem(id: 't3', label: '3')],
    answerMappings: [PracticeAnswerMapping(sourceId: 's3', targetId: 't3')],
    sequenceItems: [],
    expectedOrder: [],
  ),
];

Future<LearningAttemptRecord> _complete(
  AttemptRepository repository, {
  required double pre,
  required double post,
  required int practiceScore,
}) async {
  final attempt = await repository.startAttempt(1);
  await repository.submitAssessment(
    attemptId: attempt.id,
    type: 'pretest',
    questionOrder: const ['pre'],
    answers: const {'pre': 0},
    correctCount: 1,
    totalQuestions: 1,
    rawScore: pre,
  );
  for (var i = 0; i < 3; i++) {
    await repository.savePracticeResult(
      attemptId: attempt.id,
      activityIndex: i,
      activityType: 'match',
      correctItems: practiceScore == 0 ? 0 : 1,
      totalItems: 1,
      score: practiceScore,
    );
  }
  await repository.submitAssessment(
    attemptId: attempt.id,
    type: 'posttest',
    questionOrder: const ['post'],
    answers: const {'post': 0},
    correctCount: 1,
    totalQuestions: 1,
    rawScore: post,
    weightedScore: 70,
  );
  return repository.finalizeAttempt(attempt.id);
}
