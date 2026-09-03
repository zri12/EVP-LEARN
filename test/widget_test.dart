import 'package:evp_learn/app/app.dart';
import 'package:evp_learn/core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryLocalePreferences implements LocalePreferences {
  Locale? savedLocale;

  @override
  Future<Locale?> load() async => savedLocale;

  @override
  Future<void> save(Locale locale) async {
    savedLocale = locale;
  }
}

Future<void> _pumpRootApp(
  WidgetTester tester, {
  required _MemoryLocalePreferences preferences,
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [localePreferencesProvider.overrideWithValue(preferences)],
      child: const EvpLearnApp(),
    ),
  );
  await tester.pump(const Duration(milliseconds: 950));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Indonesian default has exactly four root destinations', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Modul'), findsOneWidget);
    expect(find.text('Progres'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.byKey(const Key('root-nav-0')), findsOneWidget);
    expect(find.byKey(const Key('root-nav-1')), findsOneWidget);
    expect(find.byKey(const Key('root-nav-2')), findsOneWidget);
    expect(find.byKey(const Key('root-nav-3')), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is InkWell &&
            widget.key is ValueKey<String> &&
            (widget.key! as ValueKey<String>).value.startsWith('root-nav-'),
      ),
      findsNWidgets(4),
    );
    expect(find.byKey(const Key('root-nav-4')), findsNothing);
  });

  testWidgets('fresh Home has no fake Continue Learning and three previews', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    expect(find.text('Lanjut Belajar'), findsNothing);
    expect(find.text('0 dari 3 Modul Selesai'), findsOneWidget);
    expect(find.byKey(const Key('overall-progress-card')), findsNothing);
  });

  testWidgets('Modules shows three unlocked module cards', (tester) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    await tester.tap(find.text('Modul'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('module-card-1')), findsOneWidget);
    expect(find.byKey(const Key('module-card-2')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('module-card-3')),
      240,
    );
    expect(find.byKey(const Key('module-card-3')), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    expect(find.text('Mulai Modul'), findsAtLeastNWidgets(1));
  });

  testWidgets('fresh Progress reports zero without scores', (tester) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('overall-progress-card')), findsOneWidget);
    expect(find.byKey(const Key('overall-progress-value')), findsOneWidget);
    expect(find.text('0%'), findsAtLeastNWidgets(1));
    expect(find.text('Nilai Terbaru'), findsNothing);
    expect(find.text('Nilai Terbaik'), findsNothing);
  });

  testWidgets('Profile renders approved static researcher fields', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();

    expect(find.text('AFRIDA DWI RAHMAWATI'), findsOneWidget);
    expect(find.text('805230006'), findsOneWidget);
    expect(
      find.text('Universitas Islam Negeri Sulthan Thaha Saifuddin Jambi'),
      findsOneWidget,
    );
    expect(find.text('2026'), findsOneWidget);
  });

  testWidgets('language selection changes root UI and persists preference', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    await tester.tap(find.byIcon(Icons.language_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.tap(find.text('Terapkan'));
    await tester.pumpAndSettle();

    expect(preferences.savedLocale, const Locale('en'));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Modules'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('root shell remains usable at supported mobile widths', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    for (final width in [360.0, 390.0, 412.0]) {
      await _pumpRootApp(
        tester,
        preferences: preferences,
        size: Size(width, 844),
      );
      expect(tester.takeException(), isNull, reason: 'width: $width');
      expect(find.text('Beranda'), findsOneWidget);
    }
  });

  testWidgets('root navigation returns to Home with a stable shell', (
    tester,
  ) async {
    final preferences = _MemoryLocalePreferences();
    await _pumpRootApp(tester, preferences: preferences);

    await tester.tap(find.byKey(const Key('root-nav-1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('module-card-1')), findsOneWidget);

    await tester.tap(find.byKey(const Key('root-nav-0')));
    await tester.pumpAndSettle();
    expect(find.text('Jelajahi Modul'), findsOneWidget);
    expect(find.byKey(const Key('root-nav-0')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
