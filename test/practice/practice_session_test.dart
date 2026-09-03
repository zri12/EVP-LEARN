import 'package:evp_learn/data/content/module_content_data_source.dart';
import 'package:evp_learn/data/repositories/module_content_repository.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/models/module_content.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/features/learning/providers/current_attempt_provider.dart';
import 'package:evp_learn/features/practice/providers/practice_session_provider.dart';
import 'package:flutter_test/flutter_test.dart';

Future<LearningModuleContent> module(String id) async =>
    (await LocalModuleContentRepository(
      AssetModuleContentDataSource(),
    ).getModuleById(id))!;

void completeCurrentActivity(PracticeSessionController controller) {
  final activity = controller.state.currentActivity;
  if (activity.kind == PracticeKind.match) {
    for (final mapping in activity.answerMappings) {
      controller.pair(mapping.sourceId, mapping.targetId);
    }
    return;
  }
  for (var index = 0; index < activity.expectedOrder.length; index++) {
    final oldIndex = controller.state.sequenceOrder.indexOf(
      activity.expectedOrder[index],
    );
    controller.reorder(oldIndex, index);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'existing inventory remains exactly three activities per module',
    () async {
      final modules = await Future.wait([
        module('module_1'),
        module('module_2'),
        module('module_3'),
      ]);
      expect(modules.map((item) => item.practices.length), [3, 3, 3]);
      expect(modules[0].practices.map((item) => item.kind), [
        PracticeKind.match,
        PracticeKind.match,
        PracticeKind.sequence,
      ]);
      expect(
        modules[1].practices.every((item) => item.kind == PracticeKind.match),
        isTrue,
      );
      expect(modules[2].practices.map((item) => item.kind), [
        PracticeKind.sequence,
        PracticeKind.match,
        PracticeKind.match,
      ]);
    },
  );

  test(
    'matching evaluates stable IDs and safely re-pairs duplicate targets',
    () async {
      final content = await module('module_1');
      final activity = content.practices.first;
      final controller = PracticeSessionController(
        moduleId: content.metadata.id,
        activities: content.practices,
      );
      final first = activity.answerMappings.first;
      final second = activity.answerMappings[1];
      controller.pair(first.sourceId, second.targetId);
      controller.pair(second.sourceId, second.targetId);
      expect(controller.state.pairings[first.sourceId], isNull);
      expect(controller.state.pairings[second.sourceId], second.targetId);
      controller.pair(first.sourceId, first.targetId);
      controller.pair(
        activity.answerMappings[2].sourceId,
        activity.answerMappings[3].targetId,
      );
      controller.pair(
        activity.answerMappings[3].sourceId,
        activity.answerMappings[2].targetId,
      );
      final result = controller.checkCurrentActivity();
      expect(result.correctItems, 2);
      expect(result.totalItems, activity.answerMappings.length);
      expect(result.score, 5);
      expect(controller.checkCurrentActivity(), same(result));
    },
  );

  test(
    'incomplete matching cannot be scored before all pairs are placed',
    () async {
      final content = await module('module_2');
      final controller = PracticeSessionController(
        moduleId: content.metadata.id,
        activities: content.practices,
      );
      controller.pair(
        content.practices.first.answerMappings.first.sourceId,
        content.practices.first.answerMappings.first.targetId,
      );
      expect(controller.state.isReadyForCheck, isFalse);
      expect(controller.state.results, isEmpty);
      expect(controller.checkCurrentActivity, throwsStateError);
      expect(controller.state.results, isEmpty);
    },
  );

  test(
    'sequence uses expectedOrder IDs and native reorder reaches full score',
    () async {
      final content = await module('module_1');
      final controller = PracticeSessionController(
        moduleId: content.metadata.id,
        activities: content.practices,
      );
      completeCurrentActivity(controller);
      controller.checkCurrentActivity();
      controller.nextActivity();
      completeCurrentActivity(controller);
      controller.checkCurrentActivity();
      controller.nextActivity();
      final activity = controller.state.currentActivity;
      expect(controller.state.sequenceOrder, isNot(activity.expectedOrder));
      for (var index = 0; index < activity.expectedOrder.length; index++) {
        final oldIndex = controller.state.sequenceOrder.indexOf(
          activity.expectedOrder[index],
        );
        controller.reorder(oldIndex, index);
      }
      expect(controller.state.sequenceOrder, activity.expectedOrder);
      expect(controller.checkCurrentActivity().score, 10);
    },
  );

  test(
    'reset restores unsubmitted activity and completed results stay frozen',
    () async {
      final content = await module('module_2');
      final controller = PracticeSessionController(
        moduleId: content.metadata.id,
        activities: content.practices,
      );
      controller.selectSource(content.practices.first.sourceItems.first.id);
      controller.resetCurrentActivity();
      expect(controller.state.pairings, isEmpty);
      completeCurrentActivity(controller);
      final result = controller.checkCurrentActivity();
      controller.pair(
        content.practices.first.sourceItems.first.id,
        content.practices.first.targetItems.first.id,
      );
      expect(controller.checkCurrentActivity(), same(result));
    },
  );

  test(
    'practice summary requires exactly three results and isolates modules',
    () async {
      final m1 = await module('module_1');
      final m2 = await module('module_2');
      final first = PracticeSessionController(
        moduleId: m1.metadata.id,
        activities: m1.practices,
      );
      expect(first.state.practiceSummary, isNull);
      completeCurrentActivity(first);
      first.checkCurrentActivity();
      first.nextActivity();
      completeCurrentActivity(first);
      first.checkCurrentActivity();
      first.nextActivity();
      completeCurrentActivity(first);
      first.checkCurrentActivity();
      expect(first.state.isComplete, isTrue);
      expect(first.state.practiceSummary, isNotNull);
      final second = PracticeSessionController(
        moduleId: m2.metadata.id,
        activities: m2.practices,
      );
      expect(second.state.results, isEmpty);
    },
  );

  test(
    'practice summary preserves per-activity scores from zero to thirty',
    () {
      final partial = PracticeScoreSummary([
        PracticeActivityScore(correctItems: 3, totalItems: 10),
        PracticeActivityScore(correctItems: 7, totalItems: 10),
        PracticeActivityScore(correctItems: 5, totalItems: 10),
      ]);
      expect(partial.activities.map((item) => item.score), [3, 7, 5]);
      expect(partial.totalScore, 15);

      final maximum = PracticeScoreSummary([
        PracticeActivityScore(correctItems: 10, totalItems: 10),
        PracticeActivityScore(correctItems: 10, totalItems: 10),
        PracticeActivityScore(correctItems: 10, totalItems: 10),
      ]);
      expect(maximum.totalScore, 30);

      final minimum = PracticeScoreSummary([
        PracticeActivityScore(correctItems: 0, totalItems: 10),
        PracticeActivityScore(correctItems: 0, totalItems: 10),
        PracticeActivityScore(correctItems: 0, totalItems: 10),
      ]);
      expect(minimum.totalScore, 0);
    },
  );

  test(
    'current attempt combines real same-module Pre, Practice, and Post results',
    () {
      final controller = CurrentAttemptController('module_1');
      final practice = PracticeScoreSummary([
        PracticeActivityScore(correctItems: 3, totalItems: 4),
        PracticeActivityScore(correctItems: 2, totalItems: 3),
        PracticeActivityScore(correctItems: 9, totalItems: 10),
      ]);
      controller.setPretest(
        const AssessmentResult(
          moduleId: 'module_1',
          type: AssessmentType.pretest,
          correct: 6,
          incorrect: 4,
          rawScore: 60,
        ),
      );
      controller.setPractice(practice);
      controller.setPosttest(
        const AssessmentResult(
          moduleId: 'module_1',
          type: AssessmentType.posttest,
          correct: 8,
          incorrect: 2,
          rawScore: 80,
          weightedScore: 56,
        ),
      );
      final finalScore = controller.state.finalCalculation!;
      expect(practice.totalScore, 24);
      expect(finalScore.finalScore, 80);
      expect(finalScore.learningGain, 20);
      expect(finalScore.passed, isTrue);
    },
  );

  test(
    'current attempt guards missing practice, missing components, and cross-module data',
    () {
      final controller = CurrentAttemptController('module_1');
      expect(controller.state.finalCalculation, isNull);
      expect(
        () => controller.setPosttest(
          const AssessmentResult(
            moduleId: 'module_1',
            type: AssessmentType.posttest,
            correct: 7,
            incorrect: 3,
            rawScore: 70,
            weightedScore: 49,
          ),
        ),
        throwsStateError,
      );
      expect(
        () => controller.setPretest(
          const AssessmentResult(
            moduleId: 'module_2',
            type: AssessmentType.pretest,
            correct: 1,
            incorrect: 9,
            rawScore: 10,
          ),
        ),
        throwsArgumentError,
      );
    },
  );

  test('failing current attempt keeps completion separate from passing', () {
    final controller = CurrentAttemptController('module_1');
    controller.setPretest(
      const AssessmentResult(
        moduleId: 'module_1',
        type: AssessmentType.pretest,
        correct: 8,
        incorrect: 2,
        rawScore: 80,
      ),
    );
    controller.setPractice(
      PracticeScoreSummary([
        PracticeActivityScore(correctItems: 2, totalItems: 3),
        PracticeActivityScore(correctItems: 2, totalItems: 3),
        PracticeActivityScore(correctItems: 3, totalItems: 5),
      ]),
    );
    controller.setPosttest(
      const AssessmentResult(
        moduleId: 'module_1',
        type: AssessmentType.posttest,
        correct: 7,
        incorrect: 3,
        rawScore: 70,
        weightedScore: 49,
      ),
    );
    expect(controller.state.finalCalculation!.finalScore, 69);
    expect(controller.state.finalCalculation!.learningGain, -10);
    expect(controller.state.finalCalculation!.completed, isTrue);
    expect(controller.state.finalCalculation!.passed, isFalse);
  });
}
