import 'package:evp_learn/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('defaults to Indonesian with four root destinations', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: EvpLearnApp()));
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Modul'), findsOneWidget);
    expect(find.text('Progres'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });

  testWidgets('root navigation resolves the modules destination', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: EvpLearnApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Modul'));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('development-placeholder-title')),
      findsOneWidget,
    );
    expect(find.text('Modul'), findsNWidgets(2));
  });
}
