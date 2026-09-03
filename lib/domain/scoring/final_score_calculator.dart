import '../models/assessment_result.dart';
import 'practice_scoring.dart';

int calculateFinalScore({
  required int postTestWeighted,
  required PracticeScoreSummary practice,
}) {
  if (postTestWeighted < 0 || postTestWeighted > 70) {
    throw ArgumentError.value(
      postTestWeighted,
      'postTestWeighted',
      'must be between 0 and 70',
    );
  }
  final score = postTestWeighted + practice.totalScore;
  if (score < 0 || score > 100) {
    throw ArgumentError.value(score, 'finalScore', 'must be between 0 and 100');
  }
  return score;
}

bool hasPassed(int finalScore) {
  if (finalScore < 0 || finalScore > 100) {
    throw ArgumentError.value(
      finalScore,
      'finalScore',
      'must be between 0 and 100',
    );
  }
  return finalScore >= FinalScoreCalculation.passingThreshold;
}

int calculateLearningGain({required int preTestRaw, required int postTestRaw}) {
  if (preTestRaw < 0 || preTestRaw > 100) {
    throw ArgumentError.value(
      preTestRaw,
      'preTestRaw',
      'must be between 0 and 100',
    );
  }
  if (postTestRaw < 0 || postTestRaw > 100) {
    throw ArgumentError.value(
      postTestRaw,
      'postTestRaw',
      'must be between 0 and 100',
    );
  }
  return postTestRaw - preTestRaw;
}
