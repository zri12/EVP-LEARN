import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../database/app_database.dart';

const currentContentVersion = 1;

/// The persisted stages are intentionally strings so migrations can add a
/// stage without changing stored learner data.
abstract final class PersistedLearningStage {
  static const overview = 'overview';
  static const objectives = 'objectives';
  static const pretest = 'pretest';
  static const pretestResult = 'pretest_result';
  static const theory = 'theory';
  static const vocabulary = 'vocabulary';
  static const reading = 'reading';
  static const practice = 'practice';
  static const posttest = 'posttest';
  static const result = 'result';
}

class LearningAttemptRecord {
  const LearningAttemptRecord({
    required this.id,
    required this.moduleId,
    required this.attemptNumber,
    required this.status,
    required this.startedAt,
    required this.contentVersion,
    required this.currentStage,
    this.currentSubIndex,
    this.currentReadingId,
    this.lastRouteKey,
    this.completedAt,
    this.pretestRaw,
    this.pretestCorrect,
    this.pretestIncorrect,
    this.practiceTotal = 0,
    this.posttestRaw,
    this.posttestWeighted,
    this.posttestCorrect,
    this.posttestIncorrect,
    this.finalScore,
    this.learningGain,
    this.passed,
  });

  final String id;
  final int moduleId;
  final int attemptNumber;
  final String status;
  final DateTime startedAt;
  final int contentVersion;
  final String currentStage;
  final int? currentSubIndex;
  final String? currentReadingId;
  final String? lastRouteKey;
  final DateTime? completedAt;
  final double? pretestRaw;
  final int? pretestCorrect;
  final int? pretestIncorrect;
  final double practiceTotal;
  final double? posttestRaw;
  final double? posttestWeighted;
  final int? posttestCorrect;
  final int? posttestIncorrect;
  final double? finalScore;
  final double? learningGain;
  final bool? passed;

  bool get isInProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';
}

class AssessmentDraft {
  const AssessmentDraft({
    required this.attemptId,
    required this.type,
    required this.questionOrder,
    required this.answers,
    required this.currentQuestionIndex,
    required this.submitted,
    this.rawScore,
    this.weightedScore,
    this.correctCount,
    this.incorrectCount,
  });

  final String attemptId;
  final String type;
  final List<String> questionOrder;
  final Map<String, int> answers;
  final int currentQuestionIndex;
  final bool submitted;
  final double? rawScore;
  final double? weightedScore;
  final int? correctCount;
  final int? incorrectCount;
}

class PracticeDraft {
  const PracticeDraft({
    required this.attemptId,
    required this.activityIndex,
    required this.activityType,
    required this.pairings,
    required this.sequenceOrder,
  });

  final String attemptId;
  final int activityIndex;
  final String activityType;
  final Map<String, String> pairings;
  final List<String> sequenceOrder;
}

class PracticeDraftCorruptionException implements Exception {
  const PracticeDraftCorruptionException(this.message);
  final String message;

  @override
  String toString() => 'PracticeDraftCorruptionException: $message';
}

class PersistenceDataCorruptionException implements Exception {
  const PersistenceDataCorruptionException(this.message);
  final String message;

  @override
  String toString() => 'PersistenceDataCorruptionException: $message';
}

class PracticeResultRecord {
  const PracticeResultRecord({
    required this.attemptId,
    required this.activityIndex,
    required this.activityType,
    required this.correctItems,
    required this.totalItems,
    required this.score,
    required this.completed,
    required this.updatedAt,
  });

  final String attemptId;
  final int activityIndex;
  final String activityType;
  final int correctItems;
  final int totalItems;
  final int score;
  final bool completed;
  final DateTime updatedAt;
}

class AttemptRepository {
  AttemptRepository(this.db);
  final AppDatabase db;

  Future<LearningAttemptRecord> startAttempt(
    int moduleId, {
    DateTime? startedAt,
    int contentVersion = currentContentVersion,
  }) async {
    _validateModule(moduleId);
    final now = startedAt ?? DateTime.now();
    return db.transaction(() async {
      final active =
          await (db.select(db.learningAttempts)
                ..where(
                  (a) =>
                      a.moduleId.equals(moduleId) &
                      a.status.equals('in_progress'),
                )
                ..limit(1))
              .getSingleOrNull();
      if (active != null) return _attempt(active);
      final rows =
          await (db.select(db.learningAttempts)
                ..where((a) => a.moduleId.equals(moduleId))
                ..orderBy([(a) => OrderingTerm.desc(a.attemptNumber)])
                ..limit(1))
              .get();
      final number = rows.isEmpty ? 1 : rows.single.attemptNumber + 1;
      final id = await _newAttemptId();
      await db
          .into(db.learningAttempts)
          .insert(
            LearningAttemptsCompanion.insert(
              id: id,
              moduleId: moduleId,
              attemptNumber: number,
              status: 'in_progress',
              startedAt: now,
              contentVersion: Value(contentVersion),
              currentStage: const Value(PersistedLearningStage.overview),
            ),
          );
      await _upsertProgress(
        moduleId,
        currentAttemptId: id,
        currentStage: PersistedLearningStage.overview,
        progressPercent: 0,
        status: 'in_progress',
        updatedAt: now,
      );
      return _attempt(
        (await (db.select(
          db.learningAttempts,
        )..where((a) => a.id.equals(id))).getSingle()),
      );
    });
  }

  Future<LearningAttemptRecord?> getCurrentAttempt(int moduleId) async {
    _validateModule(moduleId);
    final row =
        await (db.select(db.learningAttempts)
              ..where(
                (a) =>
                    a.moduleId.equals(moduleId) &
                    a.status.equals('in_progress'),
              )
              ..orderBy([(a) => OrderingTerm.desc(a.startedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _attempt(row);
  }

  Future<LearningAttemptRecord?> getAttempt(String attemptId) async {
    final row = await (db.select(
      db.learningAttempts,
    )..where((a) => a.id.equals(attemptId))).getSingleOrNull();
    return row == null ? null : _attempt(row);
  }

  Future<List<LearningAttemptRecord>> getCompletedAttempts(int moduleId) async {
    final rows =
        await (db.select(db.learningAttempts)
              ..where(
                (a) =>
                    a.moduleId.equals(moduleId) & a.status.equals('completed'),
              )
              ..orderBy([
                (a) => OrderingTerm.desc(a.completedAt),
                (a) => OrderingTerm.desc(a.startedAt),
                (a) => OrderingTerm.desc(a.attemptNumber),
              ]))
            .get();
    return rows.map(_attempt).toList(growable: false);
  }

  Future<List<LearningAttemptRecord>> getAttempts(
    int moduleId, {
    bool completedOnly = false,
  }) async {
    if (completedOnly) return getCompletedAttempts(moduleId);
    final rows =
        await (db.select(db.learningAttempts)
              ..where((a) => a.moduleId.equals(moduleId))
              ..orderBy([(a) => OrderingTerm.desc(a.startedAt)]))
            .get();
    return rows.map(_attempt).toList(growable: false);
  }

  Future<double?> getLatestScore(int moduleId) async {
    final rows = await getCompletedAttempts(moduleId);
    return rows.isEmpty ? null : rows.first.finalScore;
  }

  Future<double?> getBestScore(int moduleId) async {
    final rows = await getCompletedAttempts(moduleId);
    final scores = rows.map((row) => row.finalScore).whereType<double>();
    if (scores.isEmpty) return null;
    return scores.reduce(max);
  }

  Future<ModuleBaseline?> getBaseline(int moduleId) => (db.select(
    db.moduleBaselines,
  )..where((b) => b.moduleId.equals(moduleId))).getSingleOrNull();

  Future<void> updateStage(
    String attemptId,
    String stage, {
    int? subIndex,
    String? readingId,
    String? routeKey,
    int? progressPercent,
  }) async {
    final attempt = await getAttempt(attemptId);
    if (attempt == null) throw StateError('Attempt not found');
    if (attempt.isCompleted) return;
    // Route widgets from the previous page can finish an asynchronous
    // location write after a forward navigation has already persisted the
    // newer stage. Keep the furthest valid learning stage so that this race
    // cannot move Continue Learning backwards (for example, Pre-test to
    // Objectives during a process restart).
    if (_stageRank(stage) < _stageRank(attempt.currentStage)) {
      return;
    }
    final now = DateTime.now();
    await db.transaction(() async {
      // Re-read inside the transaction so two asynchronous page callbacks
      // cannot both pass the pre-check and let an older stage overwrite the
      // newer one.
      final current = await getAttempt(attemptId);
      if (current == null ||
          current.isCompleted ||
          _stageRank(stage) < _stageRank(current.currentStage)) {
        return;
      }
      await (db.update(
        db.learningAttempts,
      )..where((a) => a.id.equals(attemptId))).write(
        LearningAttemptsCompanion(
          currentStage: Value(stage),
          currentSubIndex: Value(subIndex),
          currentReadingId: Value(readingId),
          lastRouteKey: Value(routeKey),
        ),
      );
      final existing = await (db.select(
        db.moduleProgress,
      )..where((p) => p.moduleId.equals(current.moduleId))).getSingleOrNull();
      final percent = progressPercent ?? _progressForStage(stage);
      await _upsertProgress(
        current.moduleId,
        currentAttemptId: attemptId,
        currentStage: stage,
        currentSubIndex: subIndex,
        lastRouteKey: routeKey,
        progressPercent: percent,
        status: 'in_progress',
        updatedAt: now,
        completedAt: existing?.completedAt,
      );
    });
  }

  Future<AssessmentDraft?> getAssessmentDraft(
    String attemptId,
    String type,
  ) async {
    final row =
        await (db.select(db.assessmentSessions)..where(
              (s) =>
                  s.attemptId.equals(attemptId) & s.assessmentType.equals(type),
            ))
            .getSingleOrNull();
    return row == null ? null : _assessment(row);
  }

  Future<void> saveAssessmentDraft({
    required String attemptId,
    required String type,
    required List<String> questionOrder,
    required Map<String, int> answers,
    required int currentQuestionIndex,
    int? moduleId,
  }) async {
    _validateAssessmentType(type);
    final attempt = await getAttempt(attemptId);
    if (attempt == null || attempt.isCompleted) return;
    if (moduleId != null && moduleId != attempt.moduleId) {
      throw StateError('Assessment module does not match attempt');
    }
    final id = '${attemptId}_$type';
    final payload = jsonEncode({
      'answers': answers,
      'questionOrder': questionOrder,
      'currentQuestionIndex': currentQuestionIndex,
    });
    final existing =
        await (db.select(db.assessmentSessions)..where(
              (s) =>
                  s.attemptId.equals(attemptId) & s.assessmentType.equals(type),
            ))
            .getSingleOrNull();
    final companion = AssessmentSessionsCompanion(
      id: Value(id),
      attemptId: Value(attemptId),
      assessmentType: Value(type),
      answersJson: Value(payload),
      questionOrderJson: Value(jsonEncode(questionOrder)),
      currentQuestionIndex: Value(currentQuestionIndex),
      startedAt: Value(existing?.startedAt ?? DateTime.now()),
    );
    if (existing == null) {
      await db.into(db.assessmentSessions).insert(companion);
    } else if (!existing.submitted) {
      await (db.update(
        db.assessmentSessions,
      )..where((s) => s.id.equals(existing.id))).write(companion);
    }
  }

  Future<AssessmentDraft> submitAssessment({
    required String attemptId,
    required String type,
    required List<String> questionOrder,
    required Map<String, int> answers,
    required int correctCount,
    required int totalQuestions,
    required double rawScore,
    double? weightedScore,
    int? moduleId,
  }) async {
    _validateAssessmentType(type);
    if (correctCount < 0 ||
        correctCount > totalQuestions ||
        totalQuestions <= 0 ||
        rawScore < 0 ||
        rawScore > 100 ||
        (weightedScore != null && (weightedScore < 0 || weightedScore > 70))) {
      throw ArgumentError('Invalid assessment result');
    }
    final attempt = await getAttempt(attemptId);
    if (attempt == null) throw StateError('Attempt not found');
    if (moduleId != null && moduleId != attempt.moduleId) {
      throw StateError('Assessment module does not match attempt');
    }
    final existing = await getAssessmentDraft(attemptId, type);
    if (attempt.isCompleted && existing?.submitted != true) {
      throw StateError('Completed attempt is immutable');
    }
    if (existing?.submitted == true) {
      if (type == 'pretest' && await getBaseline(attempt.moduleId) == null) {
        await db
            .into(db.moduleBaselines)
            .insert(
              ModuleBaselinesCompanion(
                moduleId: Value(attempt.moduleId),
                attemptId: Value(attemptId),
                pretestRaw: Value(existing!.rawScore ?? rawScore),
                correctCount: Value(existing.correctCount ?? correctCount),
                incorrectCount: Value(
                  existing.incorrectCount ?? totalQuestions - correctCount,
                ),
                createdAt: Value(DateTime.now()),
              ),
            );
      }
      return existing!;
    }
    final now = DateTime.now();
    final draft = AssessmentDraft(
      attemptId: attemptId,
      type: type,
      questionOrder: List.unmodifiable(questionOrder),
      answers: Map.unmodifiable(answers),
      currentQuestionIndex: questionOrder.isEmpty
          ? 0
          : questionOrder.length - 1,
      submitted: true,
      rawScore: rawScore,
      weightedScore: weightedScore,
      correctCount: correctCount,
      incorrectCount: totalQuestions - correctCount,
    );
    await db.transaction(() async {
      final id = '${attemptId}_$type';
      final payload = jsonEncode({
        'answers': answers,
        'questionOrder': questionOrder,
        'currentQuestionIndex': draft.currentQuestionIndex,
      });
      final companion = AssessmentSessionsCompanion(
        id: Value(id),
        attemptId: Value(attemptId),
        assessmentType: Value(type),
        answersJson: Value(payload),
        questionOrderJson: Value(jsonEncode(questionOrder)),
        currentQuestionIndex: Value(draft.currentQuestionIndex),
        submitted: const Value(true),
        rawScore: Value(rawScore),
        weightedScore: Value(weightedScore),
        correctCount: Value(correctCount),
        incorrectCount: Value(totalQuestions - correctCount),
        startedAt: Value(
          existing == null
              ? now
              : (await (db.select(
                  db.assessmentSessions,
                )..where((s) => s.id.equals(id))).getSingle()).startedAt,
        ),
        submittedAt: Value(now),
      );
      final old = await (db.select(
        db.assessmentSessions,
      )..where((s) => s.id.equals(id))).getSingleOrNull();
      if (old?.submitted == true) return;
      if (old == null) {
        await db.into(db.assessmentSessions).insert(companion);
      } else {
        await (db.update(
          db.assessmentSessions,
        )..where((s) => s.id.equals(id))).write(companion);
      }
      final stage = type == 'pretest'
          ? PersistedLearningStage.pretestResult
          : PersistedLearningStage.posttest;
      await (db.update(
        db.learningAttempts,
      )..where((a) => a.id.equals(attemptId))).write(
        LearningAttemptsCompanion(
          pretestRaw: type == 'pretest'
              ? Value(rawScore)
              : const Value.absent(),
          pretestCorrect: type == 'pretest'
              ? Value(correctCount)
              : const Value.absent(),
          pretestIncorrect: type == 'pretest'
              ? Value(totalQuestions - correctCount)
              : const Value.absent(),
          posttestRaw: type == 'posttest'
              ? Value(rawScore)
              : const Value.absent(),
          posttestWeighted: type == 'posttest'
              ? Value(weightedScore)
              : const Value.absent(),
          posttestCorrect: type == 'posttest'
              ? Value(correctCount)
              : const Value.absent(),
          posttestIncorrect: type == 'posttest'
              ? Value(totalQuestions - correctCount)
              : const Value.absent(),
          currentStage: Value(stage),
        ),
      );
      await _upsertProgress(
        attempt.moduleId,
        currentAttemptId: attemptId,
        currentStage: stage,
        progressPercent: type == 'pretest' ? 20 : 80,
        status: 'in_progress',
        updatedAt: now,
      );
      if (type == 'pretest') {
        final baseline = await getBaseline(attempt.moduleId);
        if (baseline == null) {
          await db
              .into(db.moduleBaselines)
              .insert(
                ModuleBaselinesCompanion(
                  moduleId: Value(attempt.moduleId),
                  attemptId: Value(attemptId),
                  pretestRaw: Value(rawScore),
                  correctCount: Value(correctCount),
                  incorrectCount: Value(totalQuestions - correctCount),
                  createdAt: Value(now),
                ),
              );
        }
      }
    });
    return draft;
  }

  Future<PracticeDraft?> getPracticeDraft(
    String attemptId,
    int activityIndex,
  ) async {
    final row =
        await (db.select(db.practiceActivityResults)..where(
              (r) =>
                  r.attemptId.equals(attemptId) &
                  r.activityIndex.equals(activityIndex),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    final decoded = _decodeMapStrict(
      row.draftJson,
      PracticeDraftCorruptionException.new,
    );
    return PracticeDraft(
      attemptId: attemptId,
      activityIndex: activityIndex,
      activityType: row.activityType,
      pairings: _stringMap(decoded['pairings']),
      sequenceOrder: _stringList(decoded['sequenceOrder']),
    );
  }

  Future<void> savePracticeDraft({
    required String attemptId,
    required int activityIndex,
    required String activityType,
    Map<String, String> pairings = const {},
    List<String> sequenceOrder = const [],
  }) async {
    final attempt = await getAttempt(attemptId);
    if (attempt == null || attempt.isCompleted) return;
    final old =
        await (db.select(db.practiceActivityResults)..where(
              (r) =>
                  r.attemptId.equals(attemptId) &
                  r.activityIndex.equals(activityIndex),
            ))
            .getSingleOrNull();
    if (old?.completed == true) return;
    _validatePracticeType(activityType);
    final companion = PracticeActivityResultsCompanion(
      id: old == null ? const Value.absent() : Value(old.id),
      attemptId: Value(attemptId),
      activityIndex: Value(activityIndex),
      activityType: Value(activityType),
      correctItems: Value(old?.correctItems ?? 0),
      totalItems: Value(old?.totalItems ?? 0),
      score: Value(old?.score ?? 0),
      completed: Value(old?.completed ?? false),
      draftJson: Value(
        jsonEncode({'pairings': pairings, 'sequenceOrder': sequenceOrder}),
      ),
      updatedAt: Value(DateTime.now()),
    );
    if (old == null) {
      await db.into(db.practiceActivityResults).insert(companion);
    } else {
      await (db.update(
        db.practiceActivityResults,
      )..where((r) => r.id.equals(old.id))).write(companion);
    }
  }

  Future<PracticeResultRecord> savePracticeResult({
    required String attemptId,
    required int activityIndex,
    required String activityType,
    required int correctItems,
    required int totalItems,
    required int score,
  }) async {
    _validatePracticeType(activityType);
    if (activityIndex < 0 ||
        activityIndex > 2 ||
        totalItems <= 0 ||
        correctItems < 0 ||
        correctItems > totalItems ||
        score < 0 ||
        score > 10) {
      throw ArgumentError('Invalid practice result');
    }
    final attempt = await getAttempt(attemptId);
    if (attempt == null) throw StateError('Attempt not found');
    final old =
        await (db.select(db.practiceActivityResults)..where(
              (r) =>
                  r.attemptId.equals(attemptId) &
                  r.activityIndex.equals(activityIndex),
            ))
            .getSingleOrNull();
    if (old?.completed == true) return _practiceResult(old!);
    if (attempt.isCompleted) {
      throw StateError('Completed attempt is immutable');
    }
    final companion = PracticeActivityResultsCompanion(
      id: old == null ? const Value.absent() : Value(old.id),
      attemptId: Value(attemptId),
      activityIndex: Value(activityIndex),
      activityType: Value(activityType),
      correctItems: Value(correctItems),
      totalItems: Value(totalItems),
      score: Value(score),
      completed: const Value(true),
      draftJson: const Value('{}'),
      updatedAt: Value(DateTime.now()),
    );
    if (old == null) {
      await db.into(db.practiceActivityResults).insert(companion);
    } else {
      await (db.update(
        db.practiceActivityResults,
      )..where((r) => r.id.equals(old.id))).write(companion);
    }
    final results = await getPracticeResults(attemptId);
    await (db.update(
      db.learningAttempts,
    )..where((a) => a.id.equals(attemptId))).write(
      LearningAttemptsCompanion(
        practiceTotal: Value(
          results
              .where((r) => r.completed)
              .fold<int>(0, (sum, r) => sum + r.score)
              .toDouble(),
        ),
        currentStage: const Value(PersistedLearningStage.practice),
      ),
    );
    await _upsertProgress(
      attempt.moduleId,
      currentAttemptId: attemptId,
      currentStage: PersistedLearningStage.practice,
      currentSubIndex: activityIndex,
      progressPercent: results.where((r) => r.completed).length == 3 ? 80 : 65,
      status: 'in_progress',
      updatedAt: DateTime.now(),
    );
    final saved =
        await (db.select(db.practiceActivityResults)..where(
              (r) =>
                  r.attemptId.equals(attemptId) &
                  r.activityIndex.equals(activityIndex),
            ))
            .getSingle();
    return _practiceResult(saved);
  }

  Future<List<PracticeResultRecord>> getPracticeResults(
    String attemptId,
  ) async {
    final rows =
        await (db.select(db.practiceActivityResults)
              ..where((r) => r.attemptId.equals(attemptId))
              ..orderBy([(r) => OrderingTerm.asc(r.activityIndex)]))
            .get();
    return rows.map(_practiceResult).toList(growable: false);
  }

  Future<int> getPracticeTotal(String attemptId) async {
    final results = await getPracticeResults(attemptId);
    return results
        .where((result) => result.completed)
        .fold<int>(0, (sum, result) => sum + result.score);
  }

  Future<LearningAttemptRecord> finalizeAttempt(
    String attemptId, {
    int? moduleId,
  }) async {
    final existing = await getAttempt(attemptId);
    if (existing == null) throw StateError('Attempt not found');
    if (moduleId != null && moduleId != existing.moduleId) {
      throw StateError('Attempt module does not match requested module');
    }
    if (existing.isCompleted) return existing;
    return db.transaction(() async {
      final attempt = await (db.select(
        db.learningAttempts,
      )..where((a) => a.id.equals(attemptId))).getSingle();
      if (attempt.status == 'completed') return _attempt(attempt);
      final pre = await getAssessmentDraft(attemptId, 'pretest');
      final post = await getAssessmentDraft(attemptId, 'posttest');
      final practice = await getPracticeResults(attemptId);
      if (pre == null ||
          !pre.submitted ||
          pre.rawScore == null ||
          pre.correctCount == null ||
          post == null ||
          !post.submitted ||
          post.rawScore == null ||
          post.weightedScore == null ||
          post.correctCount == null ||
          practice.length != 3 ||
          practice.map((r) => r.activityIndex).toSet().length != 3 ||
          practice.any((r) => r.activityIndex < 0 || r.activityIndex > 2) ||
          !practice.map((r) => r.activityIndex).toSet().containsAll({
            0,
            1,
            2,
          }) ||
          practice.any((r) => !r.completed)) {
        throw StateError('Attempt is not ready for finalization');
      }
      final practiceTotal = practice.fold<int>(
        0,
        (sum, result) => sum + result.score,
      );
      final postWeighted = post.weightedScore ?? 0;
      final finalScore = postWeighted + practiceTotal;
      final gain = (post.rawScore ?? 0) - (pre.rawScore ?? 0);
      final now = DateTime.now();
      await (db.update(db.learningAttempts)..where(
            (a) => a.id.equals(attemptId) & a.status.equals('in_progress'),
          ))
          .write(
            LearningAttemptsCompanion(
              status: const Value('completed'),
              completedAt: Value(now),
              pretestRaw: Value(pre.rawScore),
              pretestCorrect: Value(pre.correctCount),
              pretestIncorrect: Value(pre.incorrectCount),
              practiceTotal: Value(practiceTotal.toDouble()),
              posttestRaw: Value(post.rawScore),
              posttestWeighted: Value(postWeighted),
              posttestCorrect: Value(post.correctCount),
              posttestIncorrect: Value(post.incorrectCount),
              finalScore: Value(finalScore.toDouble()),
              learningGain: Value(gain),
              passed: Value(finalScore >= 75),
              currentStage: const Value(PersistedLearningStage.result),
            ),
          );
      final moduleId = attempt.moduleId;
      await _upsertProgress(
        moduleId,
        currentAttemptId: null,
        currentStage: PersistedLearningStage.result,
        progressPercent: 100,
        status: 'completed',
        updatedAt: now,
        completedAt: now,
      );
      return _attempt(
        (await (db.select(
          db.learningAttempts,
        )..where((a) => a.id.equals(attemptId))).getSingle()),
      );
    });
  }

  Future<LearningAttemptRecord> retryModule(int moduleId) async {
    final active = await getCurrentAttempt(moduleId);
    if (active != null) return active;
    final completed = await getCompletedAttempts(moduleId);
    if (completed.isEmpty) {
      throw StateError('Module has no completed attempt to retry');
    }
    return startAttempt(moduleId);
  }

  Future<String> _newAttemptId() async {
    final random = Random.secure();
    for (var i = 0; i < 8; i++) {
      final id =
          'attempt_${DateTime.now().microsecondsSinceEpoch}_${random.nextInt(1 << 32).toRadixString(16)}';
      final exists = await (db.select(
        db.learningAttempts,
      )..where((a) => a.id.equals(id))).getSingleOrNull();
      if (exists == null) return id;
    }
    throw StateError('Could not allocate a unique attempt ID');
  }

  Future<void> _upsertProgress(
    int moduleId, {
    required String? currentAttemptId,
    required String currentStage,
    int? currentSubIndex,
    String? lastRouteKey,
    required int progressPercent,
    required String status,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) async {
    final old = await (db.select(
      db.moduleProgress,
    )..where((p) => p.moduleId.equals(moduleId))).getSingleOrNull();
    final companion = ModuleProgressCompanion(
      moduleId: Value(moduleId),
      progressPercent: Value(progressPercent.clamp(0, 100)),
      status: Value(status),
      currentStage: Value(currentStage),
      currentSubIndex: Value(currentSubIndex),
      currentAttemptId: Value(currentAttemptId),
      lastRouteKey: Value(lastRouteKey),
      updatedAt: Value(updatedAt),
      completedAt: Value(completedAt),
    );
    if (old == null) {
      await db.into(db.moduleProgress).insert(companion);
    } else {
      await (db.update(
        db.moduleProgress,
      )..where((p) => p.moduleId.equals(moduleId))).write(companion);
    }
  }

  static int _progressForStage(String stage) => switch (stage) {
    PersistedLearningStage.objectives => 10,
    PersistedLearningStage.pretest ||
    PersistedLearningStage.pretestResult => 20,
    PersistedLearningStage.theory => 35,
    PersistedLearningStage.vocabulary => 45,
    PersistedLearningStage.reading => 65,
    PersistedLearningStage.practice => 65,
    PersistedLearningStage.posttest => 80,
    PersistedLearningStage.result => 100,
    _ => 0,
  };

  /// Semantic ordering is distinct from displayed progress: Reading and
  /// Practice both display 65%, but a stale Reading callback must not regress
  /// an attempt that has already entered Practice.
  static int _stageRank(String stage) => switch (stage) {
    PersistedLearningStage.objectives => 1,
    PersistedLearningStage.pretest || PersistedLearningStage.pretestResult => 2,
    PersistedLearningStage.theory => 3,
    PersistedLearningStage.vocabulary => 4,
    PersistedLearningStage.reading => 5,
    PersistedLearningStage.practice => 6,
    PersistedLearningStage.posttest => 7,
    PersistedLearningStage.result => 8,
    _ => 0,
  };

  static LearningAttemptRecord _attempt(LearningAttempt row) =>
      LearningAttemptRecord(
        id: row.id,
        moduleId: row.moduleId,
        attemptNumber: row.attemptNumber,
        status: row.status,
        startedAt: row.startedAt,
        contentVersion: row.contentVersion,
        currentStage: row.currentStage,
        currentSubIndex: row.currentSubIndex,
        currentReadingId: row.currentReadingId,
        lastRouteKey: row.lastRouteKey,
        completedAt: row.completedAt,
        pretestRaw: row.pretestRaw,
        pretestCorrect: row.pretestCorrect,
        pretestIncorrect: row.pretestIncorrect,
        practiceTotal: row.practiceTotal,
        posttestRaw: row.posttestRaw,
        posttestWeighted: row.posttestWeighted,
        posttestCorrect: row.posttestCorrect,
        posttestIncorrect: row.posttestIncorrect,
        finalScore: row.finalScore,
        learningGain: row.learningGain,
        passed: row.passed,
      );

  static AssessmentDraft _assessment(AssessmentSession row) {
    final decoded = _decodeMapStrict(
      row.answersJson,
      PersistenceDataCorruptionException.new,
    );
    final answers = <String, int>{};
    final rawAnswers = decoded['answers'];
    if (rawAnswers is Map) {
      rawAnswers.forEach((key, value) {
        if (value is num) answers[key.toString()] = value.toInt();
      });
    }
    final embeddedOrder = _stringList(decoded['questionOrder']);
    final order = embeddedOrder.isNotEmpty
        ? embeddedOrder
        : _stringList(
            _decodeListStrict(
              row.questionOrderJson,
              PersistenceDataCorruptionException.new,
            ),
          );
    return AssessmentDraft(
      attemptId: row.attemptId,
      type: row.assessmentType,
      questionOrder: order,
      answers: answers,
      currentQuestionIndex: row.currentQuestionIndex,
      submitted: row.submitted,
      rawScore: row.rawScore,
      weightedScore: row.weightedScore,
      correctCount: row.correctCount,
      incorrectCount: row.incorrectCount,
    );
  }

  static PracticeResultRecord _practiceResult(PracticeActivityResult row) =>
      PracticeResultRecord(
        attemptId: row.attemptId,
        activityIndex: row.activityIndex,
        activityType: row.activityType,
        correctItems: row.correctItems,
        totalItems: row.totalItems,
        score: row.score,
        completed: row.completed,
        updatedAt: row.updatedAt,
      );

  static Map<String, dynamic> _decodeMapStrict(
    String source,
    Exception Function(String message) error,
  ) {
    dynamic value;
    try {
      value = jsonDecode(source);
    } catch (_) {
      throw error('Malformed JSON object');
    }
    if (value is Map<String, dynamic>) return value;
    throw error('Expected a JSON object');
  }

  static dynamic _decodeListStrict(
    String source,
    Exception Function(String message) error,
  ) {
    dynamic value;
    try {
      value = jsonDecode(source);
    } catch (_) {
      throw error('Malformed JSON array');
    }
    if (value is List) return value;
    throw error('Expected a JSON array');
  }

  static List<String> _stringList(dynamic value) => value is List
      ? value.whereType<String>().toList(growable: false)
      : const <String>[];

  static Map<String, String> _stringMap(dynamic value) => value is Map
      ? value.map((key, item) => MapEntry(key.toString(), item.toString()))
      : const <String, String>{};

  static void _validateModule(int moduleId) {
    if (moduleId < 1 || moduleId > 3) {
      throw ArgumentError.value(moduleId, 'moduleId');
    }
  }

  static void _validateAssessmentType(String type) {
    if (type != 'pretest' && type != 'posttest') {
      throw ArgumentError.value(type, 'type', 'Expected pretest or posttest');
    }
  }

  static void _validatePracticeType(String type) {
    if (type != 'match' && type != 'sequence') {
      throw ArgumentError.value(type, 'activityType');
    }
  }
}
