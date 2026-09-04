import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/assessment_result.dart';
import '../../../domain/models/module_content.dart';
import '../../../domain/scoring/assessment_scoring.dart';
import '../../../data/repositories/persistence_repository.dart';

class AssessmentDraftCorruptionException implements Exception {
  const AssessmentDraftCorruptionException(this.message);
  final String message;

  @override
  String toString() => 'AssessmentDraftCorruptionException: $message';
}

class AssessmentSessionKey {
  const AssessmentSessionKey({
    required this.moduleId,
    required this.type,
    required this.questionBank,
  });
  final String moduleId;
  final AssessmentType type;
  final QuestionBank questionBank;

  @override
  bool operator ==(Object other) =>
      other is AssessmentSessionKey &&
      other.moduleId == moduleId &&
      other.type == type &&
      other.questionBank.id == questionBank.id;
  @override
  int get hashCode => Object.hash(moduleId, type, questionBank.id);
}

class AssessmentSessionState {
  const AssessmentSessionState({
    required this.moduleId,
    required this.type,
    required this.questionBank,
    this.currentQuestionIndex = 0,
    this.answers = const <String, int>{},
    this.isComplete = false,
    this.isSubmitting = false,
    this.result,
  });

  final String moduleId;
  final AssessmentType type;
  final QuestionBank questionBank;
  final int currentQuestionIndex;
  final Map<String, int> answers;
  final bool isComplete;
  final bool isSubmitting;
  final AssessmentResult? result;
  int get totalQuestions => questionBank.questions.length;
  int get answeredCount => answers.length;
  int get unansweredCount => totalQuestions - answeredCount;
  AssessmentQuestion get currentQuestion =>
      questionBank.questions[currentQuestionIndex];

  AssessmentSessionState copyWith({
    QuestionBank? questionBank,
    int? currentQuestionIndex,
    Map<String, int>? answers,
    bool? isComplete,
    bool? isSubmitting,
    AssessmentResult? result,
  }) => AssessmentSessionState(
    moduleId: moduleId,
    type: type,
    questionBank: questionBank ?? this.questionBank,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    answers: answers ?? this.answers,
    isComplete: isComplete ?? this.isComplete,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    result: result ?? this.result,
  );
}

class AssessmentSessionController
    extends StateNotifier<AssessmentSessionState> {
  static int _nextShuffleSeed = 0;

  AssessmentSessionController({
    required String moduleId,
    required AssessmentType type,
    required QuestionBank questionBank,
    int? shuffleSeed,
  }) : super(
         AssessmentSessionState(
           moduleId: moduleId,
           type: type,
           questionBank: _shuffledQuestionBank(
             questionBank,
             shuffleSeed ?? ++_nextShuffleSeed,
           ),
         ),
       );

  AttemptRepository? _repository;
  String? _attemptId;
  bool get isPersistenceAttached => _repository != null && _attemptId != null;

  /// Attaches the controller to the durable attempt selected by the module
  /// flow. Controllers used in isolated tests may remain in-memory.
  void attachPersistence(AttemptRepository repository, String attemptId) {
    _repository = repository;
    _attemptId = attemptId;
  }

  Future<void> restoreDraft() async {
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository == null || attemptId == null) return;
    final draft = await repository.getAssessmentDraft(
      attemptId,
      state.type.name,
    );
    if (draft == null) return;
    final knownIds = state.questionBank.questions
        .map((question) => question.id)
        .toSet();
    final questionById = {
      for (final question in state.questionBank.questions)
        question.id: question,
    };
    if (draft.answers.keys.any((id) => !knownIds.contains(id)) ||
        draft.answers.entries.any(
          (entry) =>
              entry.value < 0 ||
              entry.value >= questionById[entry.key]!.options.length,
        )) {
      throw const AssessmentDraftCorruptionException(
        'Persisted answers contain an unknown question ID or invalid option',
      );
    }
    final orderIds = draft.questionOrder.toSet();
    if (draft.questionOrder.length != knownIds.length ||
        orderIds.length != draft.questionOrder.length ||
        !orderIds.containsAll(knownIds) ||
        !knownIds.containsAll(orderIds)) {
      throw const AssessmentDraftCorruptionException(
        'Persisted question order is missing, duplicated, or unknown',
      );
    }
    final byId = questionById;
    final ordered = draft.questionOrder
        .map((id) => byId[id])
        .whereType<AssessmentQuestion>()
        .toList();
    ordered.addAll(
      state.questionBank.questions.where(
        (question) => !draft.questionOrder.contains(question.id),
      ),
    );
    if (ordered.isEmpty) return;
    state = state.copyWith(
      questionBank: QuestionBank(
        id: state.questionBank.id,
        contentStatus: state.questionBank.contentStatus,
        questions: List.unmodifiable(ordered),
      ),
      answers: Map.unmodifiable(draft.answers),
      currentQuestionIndex: draft.currentQuestionIndex.clamp(
        0,
        ordered.length - 1,
      ),
      isComplete: draft.submitted,
      result: draft.submitted && draft.correctCount != null
          ? AssessmentResult(
              moduleId: state.moduleId,
              type: state.type,
              correct: draft.correctCount!,
              incorrect: draft.incorrectCount ?? 0,
              rawScore: (draft.rawScore ?? 0).round(),
              weightedScore: draft.weightedScore?.round(),
            )
          : null,
    );
  }

  Future<void> _persistDraft() async {
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository == null || attemptId == null || state.isComplete) return;
    await repository.saveAssessmentDraft(
      attemptId: attemptId,
      type: state.type.name,
      questionOrder: state.questionBank.questions
          .map((question) => question.id)
          .toList(growable: false),
      answers: state.answers,
      currentQuestionIndex: state.currentQuestionIndex,
    );
  }

  static QuestionBank _shuffledQuestionBank(QuestionBank source, int seed) {
    if (source.questions.length < 2) return source;
    final questions = List<AssessmentQuestion>.from(source.questions)
      ..shuffle(math.Random(seed));
    if (seed.isEven) questions.setAll(0, questions.reversed);
    if (questions.first.id == source.questions.first.id) {
      final first = questions.removeAt(0);
      questions.add(first);
    }
    return QuestionBank(
      id: source.id,
      contentStatus: source.contentStatus,
      questions: List.unmodifiable(questions),
    );
  }

  void selectAnswer(int optionIndex) {
    if (state.isComplete ||
        optionIndex < 0 ||
        optionIndex >= state.currentQuestion.options.length) {
      return;
    }
    final answers = Map<String, int>.from(state.answers)
      ..[state.currentQuestion.id] = optionIndex;
    state = state.copyWith(answers: Map.unmodifiable(answers));
    unawaited(_persistDraft());
  }

  void next() {
    if (state.currentQuestionIndex < state.totalQuestions - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
      unawaited(_persistDraft());
    }
  }

  void previous() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
      unawaited(_persistDraft());
    }
  }

  Future<AssessmentResult?> submit() async {
    if (state.isComplete || state.isSubmitting) return state.result;
    if (state.answeredCount != state.totalQuestions) {
      return null;
    }
    state = state.copyWith(isSubmitting: true);
    final correct = countCorrectAnswers(
      questionBank: state.questionBank,
      answers: state.answers,
    );
    final result = AssessmentResult(
      moduleId: state.moduleId,
      type: state.type,
      correct: correct,
      incorrect: state.totalQuestions - correct,
      rawScore: calculateRawScore(
        correct: correct,
        total: state.totalQuestions,
      ),
      weightedScore: state.type == AssessmentType.posttest
          ? calculatePosttestWeightedScore(
              correct: correct,
              total: state.totalQuestions,
            )
          : null,
    );
    state = state.copyWith(
      isSubmitting: false,
      isComplete: true,
      result: result,
    );
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository != null && attemptId != null) {
      await repository.submitAssessment(
        attemptId: attemptId,
        type: state.type.name,
        questionOrder: state.questionBank.questions
            .map((question) => question.id)
            .toList(growable: false),
        answers: state.answers,
        correctCount: correct,
        totalQuestions: state.totalQuestions,
        rawScore: result.rawScore.toDouble(),
        weightedScore: result.weightedScore?.toDouble(),
        moduleId: int.tryParse(state.moduleId.replaceFirst('module_', '')),
      );
    }
    return result;
  }
}

final assessmentSessionProvider = StateNotifierProvider.autoDispose
    .family<
      AssessmentSessionController,
      AssessmentSessionState,
      AssessmentSessionKey
    >(
      (ref, key) => AssessmentSessionController(
        moduleId: key.moduleId,
        type: key.type,
        questionBank: key.questionBank,
      ),
    );
