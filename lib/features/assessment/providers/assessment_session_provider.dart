import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/assessment_result.dart';
import '../../../domain/models/module_content.dart';
import '../../../domain/scoring/assessment_scoring.dart';

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
    int? currentQuestionIndex,
    Map<String, int>? answers,
    bool? isComplete,
    bool? isSubmitting,
    AssessmentResult? result,
  }) => AssessmentSessionState(
    moduleId: moduleId,
    type: type,
    questionBank: questionBank,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    answers: answers ?? this.answers,
    isComplete: isComplete ?? this.isComplete,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    result: result ?? this.result,
  );
}

class AssessmentSessionController
    extends StateNotifier<AssessmentSessionState> {
  AssessmentSessionController({
    required String moduleId,
    required AssessmentType type,
    required QuestionBank questionBank,
  }) : super(
         AssessmentSessionState(
           moduleId: moduleId,
           type: type,
           questionBank: questionBank,
         ),
       );

  void selectAnswer(int optionIndex) {
    if (state.isComplete ||
        optionIndex < 0 ||
        optionIndex >= state.currentQuestion.options.length)
      return;
    final answers = Map<String, int>.from(state.answers)
      ..[state.currentQuestion.id] = optionIndex;
    state = state.copyWith(answers: Map.unmodifiable(answers));
  }

  void next() {
    if (state.currentQuestionIndex < state.totalQuestions - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    }
  }

  void previous() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
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
    return result;
  }
}

final assessmentSessionProvider =
    StateNotifierProvider.family<
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
