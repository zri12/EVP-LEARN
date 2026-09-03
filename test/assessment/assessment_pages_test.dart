import 'package:evp_learn/features/assessment/presentation/assessment_pages.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
    final firstOption = find.byKey(const Key('assessment-option-m1_pre_q01-0'));
    expect(firstOption, findsOneWidget);
    await tester.tap(firstOption);
    await tester.tap(find.byKey(const Key('assessment-next')));
    await tester.tap(find.byKey(const Key('assessment-previous')));
    expect(
      find.byKey(firstOption.evaluate().first.widget.key!),
      findsOneWidget,
    );
    expect(find.textContaining('Question 1/10'), findsOneWidget);
  });

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
    expect(find.text('Completed — Tuntas'), findsOneWidget);
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
    expect(find.text('Completed — Perlu Review'), findsOneWidget);
  });
}
