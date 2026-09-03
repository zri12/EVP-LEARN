class PracticeActivityScore {
  PracticeActivityScore({required this.correctItems, required this.totalItems})
    : score = _calculate(correctItems, totalItems);

  final int correctItems;
  final int totalItems;
  final int score;

  factory PracticeActivityScore.fromScore({
    required int correctItems,
    required int totalItems,
    required int score,
  }) {
    final calculated = PracticeActivityScore(
      correctItems: correctItems,
      totalItems: totalItems,
    );
    if (score < 0 || score > 10 || score != calculated.score) {
      throw ArgumentError.value(
        score,
        'score',
        'must equal the rounded activity score between 0 and 10',
      );
    }
    return calculated;
  }

  static int _calculate(int correct, int total) {
    if (total <= 0)
      throw ArgumentError.value(total, 'totalItems', 'must be positive');
    if (correct < 0 || correct > total) {
      throw ArgumentError.value(
        correct,
        'correctItems',
        'must be between 0 and totalItems',
      );
    }
    return (correct * 10 / total).round();
  }
}

class PracticeScoreSummary {
  PracticeScoreSummary(Iterable<PracticeActivityScore> activities)
    : activities = List.unmodifiable(activities) {
    if (this.activities.length != 3) {
      throw ArgumentError.value(
        this.activities.length,
        'activities',
        'exactly 3 activities are required',
      );
    }
    if (totalScore > 30) {
      throw ArgumentError('Practice score cannot exceed 30');
    }
  }

  final List<PracticeActivityScore> activities;
  int get totalScore => activities.fold(0, (sum, item) => sum + item.score);
}
