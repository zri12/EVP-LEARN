import 'package:evp_learn/features/practice/presentation/practice_pages.dart';
import 'package:evp_learn/data/content/module_content_data_source.dart';
import 'package:evp_learn/data/repositories/module_content_repository.dart';
import 'package:evp_learn/domain/models/module_content.dart';
import 'package:evp_learn/features/assessment/presentation/assessment_pages.dart';
import 'package:evp_learn/features/learning/providers/learning_providers.dart';
import 'package:evp_learn/features/learning/providers/current_attempt_provider.dart';
import 'package:evp_learn/features/practice/providers/practice_session_provider.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpPractice(
  WidgetTester tester,
  String moduleId, {
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PracticePage(moduleId: moduleId),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<LearningModuleContent> loadModule(String id) async =>
    (await LocalModuleContentRepository(
      AssetModuleContentDataSource(),
    ).getModuleById(id))!;

void completeActivity(PracticeSessionController controller) {
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
  testWidgets(
    'matching renders source and target and tap fallback persists pairing',
    (tester) async {
      await pumpPractice(tester, 'module_1');
      final container = ProviderScope.containerOf(
        tester.element(find.byType(PracticePage)),
      );
      final content = await container
          .read(moduleContentRepositoryProvider)
          .getModuleById('module_1');
      final activity = content!.practices.first;
      final mapping = activity.answerMappings.first;
      expect(
        find.byKey(Key('practice-source-${mapping.sourceId}')),
        findsOneWidget,
      );
      expect(
        find.byKey(Key('practice-target-${mapping.targetId}')),
        findsOneWidget,
      );
      await tester.tap(find.byKey(Key('practice-source-${mapping.sourceId}')));
      await tester.scrollUntilVisible(
        find.byKey(Key('practice-target-${mapping.targetId}')),
        200,
      );
      await tester.tap(find.byKey(Key('practice-target-${mapping.targetId}')));
      expect(find.textContaining('Paired:'), findsOneWidget);
    },
  );

  testWidgets(
    'matching reset clears an unsubmitted pairing and check creates score',
    (tester) async {
      await pumpPractice(tester, 'module_1');
      final container = ProviderScope.containerOf(
        tester.element(find.byType(PracticePage)),
      );
      final content = await container
          .read(moduleContentRepositoryProvider)
          .getModuleById('module_1');
      final activity = content!.practices.first;
      final mapping = activity.answerMappings.first;
      await tester.tap(find.byKey(Key('practice-source-${mapping.sourceId}')));
      await tester.scrollUntilVisible(
        find.byKey(Key('practice-target-${mapping.targetId}')),
        200,
      );
      await tester.tap(find.byKey(Key('practice-target-${mapping.targetId}')));
      await tester.scrollUntilVisible(
        find.byKey(const Key('practice-reset')),
        200,
      );
      await tester.tap(find.byKey(const Key('practice-reset')));
      expect(find.textContaining('Paired: 0/4'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byKey(const Key('practice-check')),
        200,
      );
      final check = tester.widget<FilledButton>(
        find.byKey(const Key('practice-check')),
      );
      expect(check.onPressed, isNull);
      expect(find.byKey(const Key('practice-activity-result')), findsNothing);
    },
  );

  testWidgets('sequence activity renders stable IDs at supported widths', (
    tester,
  ) async {
    for (final width in [360.0, 390.0, 412.0]) {
      await pumpPractice(tester, 'module_3', size: Size(width, 844));
      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(find.byKey(const Key('practice-progress')), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'practice width $width');
    }
  });

  testWidgets('practice summary remains usable at supported widths', (
    tester,
  ) async {
    final content = await loadModule('module_1');
    final key = PracticeSessionKey(
      moduleId: content.metadata.id,
      activities: content.practices,
    );
    final controller = PracticeSessionController(
      moduleId: content.metadata.id,
      activities: content.practices,
    );
    completeActivity(controller);
    controller.checkCurrentActivity();
    controller.nextActivity();
    completeActivity(controller);
    controller.checkCurrentActivity();
    controller.nextActivity();
    completeActivity(controller);
    controller.checkCurrentActivity();
    controller.openSummary();

    for (final width in [360.0, 390.0, 412.0]) {
      await tester.binding.setSurfaceSize(Size(width, 844));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            practiceSessionProvider(key).overrideWith((ref) => controller),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const PracticePage(moduleId: 'module_1'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('practice-total')), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'summary width $width');
    }
  });

  testWidgets('final production result consumes the current attempt provider', (
    tester,
  ) async {
    final controller = CurrentAttemptController('module_1');
    controller.setPretest(
      const AssessmentResult(
        moduleId: 'module_1',
        type: AssessmentType.pretest,
        correct: 6,
        incorrect: 4,
        rawScore: 60,
      ),
    );
    controller.setPractice(
      PracticeScoreSummary([
        PracticeActivityScore(correctItems: 3, totalItems: 4),
        PracticeActivityScore(correctItems: 2, totalItems: 3),
        PracticeActivityScore(correctItems: 9, totalItems: 10),
      ]),
    );
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
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentAttemptProvider('module_1').overrideWith((ref) => controller),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const FinalResultPage(moduleId: 'module_1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('80/100'), findsNWidgets(2));
    expect(find.textContaining('56/70'), findsOneWidget);
    expect(find.textContaining('24/30'), findsOneWidget);
    expect(find.text('Completed — Tuntas'), findsOneWidget);
  });

  testWidgets('final result does not fabricate incomplete attempt values', (
    tester,
  ) async {
    final stages = <CurrentAttemptController>[];
    stages.add(CurrentAttemptController('module_1'));

    final preOnly = CurrentAttemptController('module_1');
    preOnly.setPretest(
      const AssessmentResult(
        moduleId: 'module_1',
        type: AssessmentType.pretest,
        correct: 1,
        incorrect: 9,
        rawScore: 10,
      ),
    );
    stages.add(preOnly);

    final withoutPost = CurrentAttemptController('module_1');
    withoutPost.setPretest(
      const AssessmentResult(
        moduleId: 'module_1',
        type: AssessmentType.pretest,
        correct: 1,
        incorrect: 9,
        rawScore: 10,
      ),
    );
    withoutPost.setPractice(
      PracticeScoreSummary([
        PracticeActivityScore(correctItems: 0, totalItems: 1),
        PracticeActivityScore(correctItems: 0, totalItems: 1),
        PracticeActivityScore(correctItems: 0, totalItems: 1),
      ]),
    );
    stages.add(withoutPost);

    for (final controller in stages) {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentAttemptProvider(
              'module_1',
            ).overrideWith((ref) => controller),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const FinalResultPage(moduleId: 'module_1'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Final results require'), findsOneWidget);
    }
  });
}
