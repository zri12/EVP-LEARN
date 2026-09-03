import 'package:flutter_test/flutter_test.dart';

import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/models/module_content.dart';
import 'package:evp_learn/features/assessment/providers/assessment_session_provider.dart';

AssessmentQuestion question(String id, int correct) => AssessmentQuestion(
  id: id,
  prompt: 'Question $id',
  options: const ['A', 'B', 'C', 'D'],
  correctOptionIndex: correct,
  imageKey: null,
  feedback: null,
  contentStatus: ContentStatus.prototypeDerived,
);

QuestionBank bank(String id) => QuestionBank(
  id: id,
  contentStatus: ContentStatus.prototypeDerived,
  questions: [question('${id}_1', 0), question('${id}_2', 1)],
);

void main() {
  test('retains answers when moving back and submits idempotently', () async {
    final controller = AssessmentSessionController(
      moduleId: 'module_1',
      type: AssessmentType.pretest,
      questionBank: bank('pre'),
    );
    controller.selectAnswer(0);
    controller.next();
    controller.selectAnswer(1);
    controller.previous();
    expect(controller.state.answers['pre_1'], 0);
    final result = await controller.submit();
    expect(result!.rawScore, 100);
    expect(await controller.submit(), same(result));
  });

  test('incomplete session cannot submit', () async {
    final controller = AssessmentSessionController(
      moduleId: 'module_2',
      type: AssessmentType.posttest,
      questionBank: bank('post'),
    );
    controller.selectAnswer(0);
    expect(await controller.submit(), isNull);
    expect(controller.state.isComplete, isFalse);
  });

  test('sessions are isolated by module and assessment type', () {
    final pre = AssessmentSessionController(
      moduleId: 'module_1',
      type: AssessmentType.pretest,
      questionBank: bank('pre'),
    );
    final post = AssessmentSessionController(
      moduleId: 'module_1',
      type: AssessmentType.posttest,
      questionBank: bank('post'),
    );
    pre.selectAnswer(1);
    expect(post.state.answeredCount, 0);
  });
}
