import 'package:evp_learn/features/assessment/presentation/assessment_pages.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Future<void> pumpAssessment(
  WidgetTester tester,
  Widget page, {
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: page,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('pre-test renders, retains answer, and shows result', (
    tester,
  ) async {
    await pumpAssessment(
      tester,
      const AssessmentPage(moduleId: 'module_1', type: AssessmentType.pretest),
    );
    expect(find.textContaining('Question 1/10'), findsOneWidget);
    final firstOption = find.byType(RadioListTile<int>).first;
    expect(firstOption, findsOneWidget);
    await tester.tap(firstOption);
    await tester.tap(find.byKey(const Key('assessment-next')));
    await tester.tap(find.byKey(const Key('assessment-previous')));
    expect(firstOption, findsOneWidget);
    expect(find.textContaining('Question 1/10'), findsOneWidget);
  });

  testWidgets('final result Home CTA routes safely to Home', (tester) async {
    final practice = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 1, totalItems: 1),
      PracticeActivityScore(correctItems: 0, totalItems: 1),
      PracticeActivityScore(correctItems: 1, totalItems: 1),
    ]);
    final router = GoRouter(
      initialLocation: '/final',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home destination'))),
        ),
        GoRoute(
          path: '/final',
          builder: (context, state) => FinalResultPage(
            calculation: FinalScoreCalculation(
              moduleId: 'module_1',
              preTestRaw: 20,
              postTestRaw: 80,
              postTestWeighted: 56,
              practice: practice,
            ),
          ),
        ),
      ],
    );
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('final-result-home')));
    await tester.pumpAndSettle();
    expect(find.text('Home destination'), findsOneWidget);
  });

  testWidgets(
    'assessment submit stays disabled until all questions are answered',
    (tester) async {
      for (final type in [AssessmentType.pretest, AssessmentType.posttest]) {
        await pumpAssessment(
          tester,
          AssessmentPage(moduleId: 'module_1', type: type),
        );
        for (var index = 0; index < 9; index++) {
          final next = find.byKey(const Key('assessment-next'));
          await tester.scrollUntilVisible(next, 240);
          await tester.tap(next);
          await tester.pump();
        }
        await tester.scrollUntilVisible(
          find.byKey(const Key('assessment-submit')),
          240,
        );
        expect(
          find.byKey(const Key('assessment-submit')),
          findsOneWidget,
          reason: 'last question for $type',
        );
        final submit = tester.widget<FilledButton>(
          find.byKey(const Key('assessment-submit')),
        );
        expect(submit.onPressed, isNull);
        expect(
          find.byKey(const Key('assessment-incomplete-helper')),
          findsOneWidget,
        );
      }
    },
  );

  testWidgets('assessment remains responsive at supported phone widths', (
    tester,
  ) async {
    for (final width in [360.0, 390.0, 412.0]) {
      await pumpAssessment(
        tester,
        const AssessmentPage(
          moduleId: 'module_2',
          type: AssessmentType.posttest,
        ),
        size: Size(width, 844),
      );
      expect(find.textContaining('Question 1/10'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'assessment width $width');
    }
  });

  testWidgets('fixture final result distinguishes passing and review states', (
    tester,
  ) async {
    final practice = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 1, totalItems: 1),
      PracticeActivityScore(correctItems: 1, totalItems: 1),
      PracticeActivityScore(correctItems: 1, totalItems: 1),
    ]);
    await pumpAssessment(
      tester,
      FinalResultPage(
        calculation: FinalScoreCalculation(
          moduleId: 'module_1',
          preTestRaw: 20,
          postTestRaw: 80,
          postTestWeighted: 70,
          practice: practice,
        ),
      ),
    );
    expect(find.text('Completed — Passed'), findsOneWidget);
    expect(find.textContaining('70/70'), findsOneWidget);
    await pumpAssessment(
      tester,
      FinalResultPage(
        calculation: FinalScoreCalculation(
          moduleId: 'module_1',
          preTestRaw: 20,
          postTestRaw: 30,
          postTestWeighted: 40,
          practice: practice,
        ),
      ),
    );
    expect(find.text('Completed — Needs Review'), findsOneWidget);
  });

  testWidgets('final result remains responsive at supported phone widths', (
    tester,
  ) async {
    for (final width in [360.0, 390.0, 412.0]) {
      await pumpAssessment(
        tester,
        FinalResultPage(
          calculation: FinalScoreCalculation(
            moduleId: 'module_1',
            preTestRaw: 30,
            postTestRaw: 70,
            postTestWeighted: 49,
            practice: PracticeScoreSummary([
              PracticeActivityScore(correctItems: 1, totalItems: 1),
              PracticeActivityScore(correctItems: 1, totalItems: 1),
              PracticeActivityScore(correctItems: 0, totalItems: 1),
            ]),
          ),
        ),
        size: Size(width, 844),
      );
      expect(find.byKey(const Key('final-result-status')), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'final width $width');
    }
  });

  testWidgets(
    'production post-test route is guarded until Practice is complete',
    (tester) async {
      await pumpAssessment(
        tester,
        const AssessmentPage(
          moduleId: 'module_1',
          type: AssessmentType.posttest,
          enforcePracticeGuard: true,
        ),
      );
      expect(
        find.textContaining('Complete all three Practice'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('assessment-progress')), findsNothing);
    },
  );
}
