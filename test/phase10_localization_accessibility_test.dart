import 'package:evp_learn/core/widgets/app_progress_bar.dart';
import 'package:evp_learn/domain/models/assessment_result.dart';
import 'package:evp_learn/domain/scoring/practice_scoring.dart';
import 'package:evp_learn/features/assessment/presentation/assessment_pages.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:evp_learn/l10n/app_localizations_en.dart';
import 'package:evp_learn/l10n/app_localizations_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _localizedProgress(Locale locale) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(body: AppProgressBar(value: 65)),
);

void main() {
  testWidgets('progress semantics follow the selected system locale', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(_localizedProgress(const Locale('id')));
    expect(find.bySemanticsLabel('Progres 65%'), findsOneWidget);

    await tester.pumpWidget(_localizedProgress(const Locale('en')));
    expect(find.bySemanticsLabel('Progress 65%'), findsOneWidget);
    semantics.dispose();
  });

  test('system status terminology is not mixed between locales', () {
    final id = AppLocalizationsId();
    final en = AppLocalizationsEn();

    expect(id.tuntas, 'Selesai — Tuntas');
    expect(id.needsReview, 'Selesai — Perlu Review');
    expect(en.tuntas, 'Completed — Passed');
    expect(en.needsReview, 'Completed — Needs Review');
    expect(id.languageTitle, 'Bahasa');
    expect(en.languageTitle, 'Language');
  });

  testWidgets('final result remains usable at accessible text scales', (
    tester,
  ) async {
    final practice = PracticeScoreSummary([
      PracticeActivityScore(correctItems: 1, totalItems: 1),
      PracticeActivityScore(correctItems: 1, totalItems: 1),
      PracticeActivityScore(correctItems: 1, totalItems: 1),
    ]);
    for (final scale in [1.0, 1.3, 1.5]) {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: FinalResultPage(
              calculation: FinalScoreCalculation(
                moduleId: 'module_1',
                preTestRaw: 40,
                postTestRaw: 80,
                postTestWeighted: 56,
                practice: practice,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'text scale: $scale');
    }
  });
}
