import 'package:flutter_test/flutter_test.dart';

import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/scoring/assessment_scoring.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/domain/scoring/final_score_calculator.dart';

void main() {
  test('raw scores use rounded percentage and post-test uses /70', () {
    expect(calculateRawScore(correct: 0, total: 10), 0);
    expect(calculateRawScore(correct: 1, total: 10), 10);
    expect(calculateRawScore(correct: 5, total: 10), 50);
    expect(calculateRawScore(correct: 10, total: 10), 100);
    expect(calculatePosttestWeightedScore(correct: 0, total: 10), 0);
    expect(calculatePosttestWeightedScore(correct: 1, total: 10), 7);
    expect(calculatePosttestWeightedScore(correct: 5, total: 10), 35);
    expect(calculatePosttestWeightedScore(correct: 7, total: 10), 49);
    expect(calculatePosttestWeightedScore(correct: 10, total: 10), 70);
  });

  test('practice rounds each activity independently', () {
    final summary = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 1, totalItems: 4),
      PracticeActivityScore(correctItems: 1, totalItems: 4),
      PracticeActivityScore(correctItems: 1, totalItems: 4),
    ]);
    expect(summary.activities.map((item) => item.score), [3, 3, 3]);
    expect(summary.totalScore, 9);
    // Aggregate rounding would produce round(3 / 12 * 30) = 8; it is not used.
    expect((3 * 30 / 12).round(), 8);
    expect(summary.totalScore, isNot((3 * 30 / 12).round()));
  });

  test('final score excludes pre-test and applies threshold at 75', () {
    final calculation = FinalScoreCalculation(
      moduleId: 'module_1',
      preTestRaw: 100,
      practice: PracticeScoreSummary([
        PracticeActivityScore(correctItems: 1, totalItems: 1),
        PracticeActivityScore(correctItems: 1, totalItems: 1),
        PracticeActivityScore(correctItems: 1, totalItems: 1),
      ]),
      postTestRaw: 60,
      postTestWeighted: 45,
    );
    expect(calculation.finalScore, 75);
    expect(calculation.passed, isTrue);
    expect(calculation.completed, isTrue);
    expect(calculation.learningGain, -40);
  });

  test('final score and passing edges are exact', () {
    final practice = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 0, totalItems: 1),
      PracticeActivityScore(correctItems: 0, totalItems: 1),
      PracticeActivityScore(correctItems: 0, totalItems: 1),
    ]);
    expect(calculateFinalScore(postTestWeighted: 0, practice: practice), 0);
    expect(hasPassed(74), isFalse);
    expect(hasPassed(75), isTrue);
    expect(hasPassed(76), isTrue);
    expect(hasPassed(100), isTrue);
    expect(calculateLearningGain(preTestRaw: 40, postTestRaw: 80), 40);
  });

  test('pre-test remains excluded from identical final scores', () {
    final practice = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 3, totalItems: 4),
      PracticeActivityScore(correctItems: 3, totalItems: 4),
      PracticeActivityScore(correctItems: 4, totalItems: 4),
    ]);
    final attemptA = FinalScoreCalculation(
      moduleId: 'm',
      preTestRaw: 20,
      postTestRaw: 70,
      postTestWeighted: 49,
      practice: practice,
    );
    final attemptB = FinalScoreCalculation(
      moduleId: 'm',
      preTestRaw: 100,
      postTestRaw: 70,
      postTestWeighted: 49,
      practice: practice,
    );
    expect(practice.totalScore, 26);
    expect(attemptA.finalScore, 75);
    expect(attemptB.finalScore, 75);
  });

  test('gain can be positive or zero and invalid values are rejected', () {
    expect(
      FinalScoreCalculation(
        moduleId: 'm',
        preTestRaw: 50,
        postTestRaw: 50,
        postTestWeighted: 35,
        practice: PracticeScoreSummary([
          PracticeActivityScore(correctItems: 0, totalItems: 1),
          PracticeActivityScore(correctItems: 0, totalItems: 1),
          PracticeActivityScore(correctItems: 0, totalItems: 1),
        ]),
      ).learningGain,
      0,
    );
    // A first-ever baseline of 40 is intentionally irrelevant to retry gain.
    expect(calculateLearningGain(preTestRaw: 80, postTestRaw: 90), 10);
    expect(calculateLearningGain(preTestRaw: 80, postTestRaw: 60), -20);
    expect(
      () => calculateRawScore(correct: 11, total: 10),
      throwsArgumentError,
    );
    expect(
      () => PracticeActivityScore(correctItems: 2, totalItems: 1),
      throwsArgumentError,
    );
    expect(
      () => PracticeActivityScore.fromScore(
        correctItems: 1,
        totalItems: 1,
        score: 11,
      ),
      throwsArgumentError,
    );
    expect(() => PracticeScoreSummary(const []), throwsArgumentError);
    expect(
      () => FinalScoreCalculation(
        moduleId: 'm',
        preTestRaw: 0,
        postTestRaw: 0,
        postTestWeighted: 71,
        practice: PracticeScoreSummary([
          PracticeActivityScore(correctItems: 0, totalItems: 1),
          PracticeActivityScore(correctItems: 0, totalItems: 1),
          PracticeActivityScore(correctItems: 0, totalItems: 1),
        ]),
      ),
      throwsArgumentError,
    );
  });
}
