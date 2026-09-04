import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:evp_learn/app/theme/app_theme.dart';
import 'package:evp_learn/data/database/app_database.dart';
import 'package:evp_learn/data/providers/database_providers.dart';
import 'package:evp_learn/features/progress/presentation/progress_page.dart';
import 'package:evp_learn/features/progress/providers/progress_history_provider.dart';
import 'package:evp_learn/data/repositories/persistence_repository.dart';
import 'package:evp_learn/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('fresh progress shows three modules and empty detail', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const Scaffold(body: ProgressPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('overall-progress-value')), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);
    expect(find.byKey(const Key('progress-module-card-1')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('progress-module-card-2')),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('progress-module-card-2')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('progress-module-card-3')),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('progress-module-card-3')), findsOneWidget);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const ModuleProgressDetailPage(moduleId: '1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No evaluation results yet'), findsOneWidget);
  });

  testWidgets('progress root remains usable at supported phone widths', (
    tester,
  ) async {
    for (final width in [360.0, 390.0, 412.0]) {
      final database = AppDatabase(NativeDatabase.memory());
      await tester.binding.setSurfaceSize(Size(width, 844));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(database)],
          child: MaterialApp(
            theme: AppTheme.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: const Scaffold(body: ProgressPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 20));
      expect(tester.takeException(), isNull);
      await database.close();
    }
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('attempt detail validates module and completion state', (
    tester,
  ) async {
    final completed = LearningAttemptRecord(
      id: 'completed',
      moduleId: 1,
      attemptNumber: 4,
      status: 'completed',
      startedAt: DateTime(2026, 1, 1),
      completedAt: DateTime(2026, 1, 2),
      contentVersion: 1,
      currentStage: PersistedLearningStage.result,
      pretestRaw: 80,
      practiceTotal: 10,
      posttestRaw: 70,
      posttestWeighted: 70,
      finalScore: 80,
      learningGain: -10,
      passed: true,
    );
    Future<void> pumpDetail(
      String moduleId,
      LearningAttemptRecord? value, {
      Locale locale = const Locale('en'),
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            attemptDetailProvider(
              'completed',
            ).overrideWith((ref) async => value),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: AttemptDetailPage(moduleId: moduleId, attemptId: 'completed'),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpDetail('1', completed);
    expect(find.text('80/100'), findsNWidgets(2));
    expect(find.textContaining('Jan 2, 2026'), findsOneWidget);
    await pumpDetail('1', completed, locale: const Locale('id'));
    expect(find.textContaining('2 Jan 2026'), findsOneWidget);
    await pumpDetail('2', completed);
    expect(find.textContaining('unavailable'), findsOneWidget);
    await pumpDetail('99', completed);
    expect(find.textContaining('unavailable'), findsOneWidget);
  });
}
