import 'package:evp_learn/features/learning/presentation/learning_pages.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpLearningPage(
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
  testWidgets('objectives are rendered from each module JSON document', (
    tester,
  ) async {
    await pumpLearningPage(
      tester,
      const LearningObjectivesPage(moduleId: 'module_1'),
    );
    expect(
      find.text('Mengidentifikasi fungsi sosial teks berkaitan retail.'),
      findsOneWidget,
    );

    await pumpLearningPage(
      tester,
      const LearningObjectivesPage(moduleId: 'module_2'),
    );
    expect(
      find.text('Mengenali struktur generik dan ciri kebahasaan.'),
      findsOneWidget,
    );

    await pumpLearningPage(
      tester,
      const LearningObjectivesPage(moduleId: 'module_3'),
    );
    expect(
      find.text('Memahami ide pokok dan informasi rinci.'),
      findsOneWidget,
    );
  });

  testWidgets(
    'theory, vocabulary, and reading pages stay usable at phone widths',
    (tester) async {
      for (final width in [360.0, 390.0, 412.0]) {
        await pumpLearningPage(
          tester,
          const TheoryPage(moduleId: 'module_1'),
          size: Size(width, 844),
        );
        await tester.scrollUntilVisible(find.text('Orientation'), 260);
        expect(find.text('Orientation'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: 'theory width $width');

        await pumpLearningPage(
          tester,
          const VocabularyPage(moduleId: 'module_2'),
          size: Size(width, 844),
        );
        expect(find.text('Merchandise'), findsOneWidget);
        expect(find.text('Sleek'), findsOneWidget);
        expect(
          tester.takeException(),
          isNull,
          reason: 'vocabulary width $width',
        );

        await pumpLearningPage(
          tester,
          const ReadingPage(moduleId: 'module_3', readingId: 'm3_reading_01'),
          size: Size(width, 844),
        );
        expect(
          find.textContaining('HOW TO PROCESS CUSTOMER CHECKOUT'),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull, reason: 'reading width $width');
      }
    },
  );

  testWidgets('each theory module has a hero and three custom illustrations', (
    tester,
  ) async {
    for (final moduleId in ['module_1', 'module_2', 'module_3']) {
      final number = moduleId.split('_').last;
      await pumpLearningPage(tester, TheoryPage(moduleId: moduleId));
      expect(find.byKey(Key('module$number-theory-hero')), findsOneWidget);
      expect(
        find.byKey(Key('module$number-theory-illustration-1')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byKey(Key('module$number-theory-illustration-2')),
        260,
      );
      expect(
        find.byKey(Key('module$number-theory-illustration-2')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byKey(Key('module$number-theory-illustration-3')),
        260,
      );
      expect(
        find.byKey(Key('module$number-theory-illustration-3')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull, reason: '$moduleId visuals');
    }
  });

  testWidgets(
    'formal glossary opens from a reading and excludes non-formal M2 term',
    (tester) async {
      await pumpLearningPage(
        tester,
        const ReadingPage(moduleId: 'module_2', readingId: 'm2_reading_03'),
      );
      await tester.tap(
        find.byKey(const Key('glossary-m2_r3_glossary_premium')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Premium'), findsOneWidget);
      expect(find.textContaining('Berkualitas tinggi'), findsOneWidget);
      expect(find.text('Genuine'), findsNothing);
    },
  );

  testWidgets(
    'M2 has three reading selectors and adjustable is tappable in both readings',
    (tester) async {
      await pumpLearningPage(
        tester,
        const ReadingPage(moduleId: 'module_2', readingId: 'm2_reading_02'),
      );
      expect(find.byType(ChoiceChip), findsNWidgets(3));
      final adjustable = find.byKey(
        const Key('glossary-m2_r2_glossary_adjustable'),
      );
      await tester.ensureVisible(adjustable);
      await tester.pumpAndSettle();
      await tester.tap(adjustable);
      await tester.pumpAndSettle();
      expect(find.text('Adjustable'), findsOneWidget);
    },
  );
}
