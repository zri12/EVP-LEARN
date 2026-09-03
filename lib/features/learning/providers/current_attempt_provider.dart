import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/assessment_result.dart';
import '../../../domain/scoring/practice_scoring.dart';

class CurrentAttemptState {
  const CurrentAttemptState({
    required this.moduleId,
    this.pretestResult,
    this.practiceSummary,
    this.posttestResult,
  });
  final String moduleId;
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
  CurrentAttemptController(String moduleId)
    : super(CurrentAttemptState(moduleId: moduleId));

  void setPretest(AssessmentResult result) {
    _guard(result);
    if (result.type != AssessmentType.pretest)
      throw ArgumentError('Expected a Pre-test result');
    state = CurrentAttemptState(
      moduleId: state.moduleId,
      pretestResult: result,
      practiceSummary: state.practiceSummary,
      posttestResult: state.posttestResult,
    );
  }

  void setPractice(PracticeScoreSummary summary) => state = CurrentAttemptState(
    moduleId: state.moduleId,
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
    >((ref, moduleId) => CurrentAttemptController(moduleId));
