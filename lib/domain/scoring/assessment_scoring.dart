import '../models/module_content.dart';

int calculateRawScore({required int correct, required int total}) {
  _validateCounts(correct, total);
  return (correct * 100 / total).round();
}

int calculatePosttestWeightedScore({required int correct, required int total}) {
  _validateCounts(correct, total);
  return (correct * 70 / total).round();
}

int countCorrectAnswers({
  required QuestionBank questionBank,
  required Map<String, int> answers,
}) {
  var correct = 0;
  for (final question in questionBank.questions) {
    if (answers[question.id] == question.correctOptionIndex) correct++;
  }
  return correct;
}

void _validateCounts(int correct, int total) {
  if (total <= 0) throw ArgumentError.value(total, 'total', 'must be positive');
  if (correct < 0 || correct > total) {
    throw ArgumentError.value(
      correct,
      'correct',
      'must be between 0 and total',
    );
  }
}
