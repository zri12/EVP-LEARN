import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_providers.dart';
import '../../../data/repositories/persistence_repository.dart';
import '../../../domain/models/assessment_result.dart';
import '../../../domain/scoring/practice_scoring.dart';

class CurrentAttemptState {
  const CurrentAttemptState({
    required this.moduleId,
    this.attemptId,
    this.pretestResult,
    this.practiceSummary,
    this.posttestResult,
  });
  final String moduleId;
  final String? attemptId;
  final AssessmentResult? pretestResult;
  final PracticeScoreSummary? practiceSummary;
  final AssessmentResult? posttestResult;
  bool get hasCompletePractice => practiceSummary != null;
  FinalScoreCalculation? get finalCalculation {
    final pre = pretestResult;
    final practice = practiceSummary;
    final post = posttestResult;
    if (pre == null ||
        practice == null ||
        post == null ||
        post.weightedScore == null)
      return null;
    return FinalScoreCalculation(
      moduleId: moduleId,
      preTestRaw: pre.rawScore,
      practice: practice,
      postTestRaw: post.rawScore,
      postTestWeighted: post.weightedScore!,
    );
  }
}

class CurrentAttemptController extends StateNotifier<CurrentAttemptState> {
  CurrentAttemptController(String moduleId, [AttemptRepository? repository])
    : _repository = repository,
      super(CurrentAttemptState(moduleId: moduleId)) {
    _hydrate();
  }

  final AttemptRepository? _repository;

  Future<void> _hydrate() async {
    final repository = _repository;
    final moduleNumber = int.tryParse(
      state.moduleId.replaceFirst('module_', ''),
    );
    if (repository == null || moduleNumber == null) return;
    final attempt = await repository.getCurrentAttempt(moduleNumber);
    if (attempt == null || !mounted) return;
    final pre = await repository.getAssessmentDraft(attempt.id, 'pretest');
    final post = await repository.getAssessmentDraft(attempt.id, 'posttest');
    final practiceRows = await repository.getPracticeResults(attempt.id);
    final preResult = pre?.submitted == true && pre?.correctCount != null
        ? AssessmentResult(
            moduleId: state.moduleId,
            type: AssessmentType.pretest,
            correct: pre!.correctCount!,
            incorrect: pre.incorrectCount ?? 0,
            rawScore: (pre.rawScore ?? 0).round(),
          )
        : null;
    final postResult = post?.submitted == true && post?.correctCount != null
        ? AssessmentResult(
            moduleId: state.moduleId,
            type: AssessmentType.posttest,
            correct: post!.correctCount!,
            incorrect: post.incorrectCount ?? 0,
            rawScore: (post.rawScore ?? 0).round(),
            weightedScore: (post.weightedScore ?? 0).round(),
          )
        : null;
    final practice =
        practiceRows.length == 3 && practiceRows.every((row) => row.completed)
        ? PracticeScoreSummary(
            practiceRows.map(
              (row) => PracticeActivityScore.fromScore(
                correctItems: row.correctItems,
                totalItems: row.totalItems,
                score: row.score,
              ),
            ),
          )
        : null;
    state = CurrentAttemptState(
      moduleId: state.moduleId,
      attemptId: attempt.id,
      pretestResult: preResult,
      practiceSummary: practice,
      posttestResult: postResult,
    );
  }

  void setPretest(AssessmentResult result) {
    _guard(result);
    if (result.type != AssessmentType.pretest)
      throw ArgumentError('Expected a Pre-test result');
    state = CurrentAttemptState(
      moduleId: state.moduleId,
      attemptId: state.attemptId,
      pretestResult: result,
      practiceSummary: state.practiceSummary,
      posttestResult: state.posttestResult,
    );
  }

  void setPractice(PracticeScoreSummary summary) => state = CurrentAttemptState(
    moduleId: state.moduleId,
    attemptId: state.attemptId,
    pretestResult: state.pretestResult,
    practiceSummary: summary,
    posttestResult: state.posttestResult,
  );

  void setPosttest(AssessmentResult result) {
    _guard(result);
    if (result.type != AssessmentType.posttest)
      throw ArgumentError('Expected a Post-test result');
    if (!state.hasCompletePractice)
      throw StateError('Practice must be complete before Post-test');
    state = CurrentAttemptState(
      moduleId: state.moduleId,
      attemptId: state.attemptId,
      pretestResult: state.pretestResult,
      practiceSummary: state.practiceSummary,
      posttestResult: result,
    );
  }

  void _guard(AssessmentResult result) {
    if (result.moduleId != state.moduleId)
      throw ArgumentError('Assessment module does not match current attempt');
  }
}

final currentAttemptProvider =
    StateNotifierProvider.family<
      CurrentAttemptController,
      CurrentAttemptState,
      String
    >(
      (ref, moduleId) => CurrentAttemptController(
        moduleId,
        ref.watch(attemptRepositoryProvider),
      ),
    );
