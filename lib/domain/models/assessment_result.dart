import '../scoring/practice_scoring.dart';

enum AssessmentType { pretest, posttest }

class AssessmentResult {
  const AssessmentResult({
    required this.moduleId,
    required this.type,
    required this.correct,
    required this.incorrect,
    required this.rawScore,
    this.weightedScore,
  });

  final String moduleId;
  final AssessmentType type;
  final int correct;
  final int incorrect;
  final int rawScore;
  final int? weightedScore;
}

class FinalScoreCalculation {
  FinalScoreCalculation({
    required this.moduleId,
    required this.preTestRaw,
    required this.practice,
    required this.postTestRaw,
    required this.postTestWeighted,
  }) : finalScore = postTestWeighted + practice.totalScore,
       learningGain = postTestRaw - preTestRaw,
       passed = postTestWeighted + practice.totalScore >= passingThreshold,
       completed = true {
    validate();
  }

  static const passingThreshold = 75;
  final String moduleId;
  final int preTestRaw;
  final PracticeScoreSummary practice;
  final int postTestRaw;
  final int postTestWeighted;
  final int finalScore;
  final int learningGain;
  final bool passed;

  /// Finalization and passing are separate semantics.
  final bool completed;

  void validate() {
    if (preTestRaw < 0 || preTestRaw > 100) {
      throw ArgumentError('Invalid pre-test score');
    }
    if (postTestRaw < 0 || postTestRaw > 100) {
      throw ArgumentError('Invalid post-test score');
    }
    if (postTestWeighted < 0 || postTestWeighted > 70) {
      throw ArgumentError('Invalid weighted score');
    }
    if (finalScore < 0 || finalScore > 100) {
      throw ArgumentError('Invalid final score');
    }
  }
}
