import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const root = '/';
  static const home = '/home';
  static const modules = '/modules';
  static const progress = '/progress';
  static const profile = '/profile';

  static String moduleOverview(int moduleId) => '/module/$moduleId';
  static String objectives(int moduleId) => '/module/$moduleId/objectives';
  static String pretest(int moduleId) => '/module/$moduleId/pretest';
  static String theory(int moduleId) => '/module/$moduleId/theory';
  static String vocabulary(int moduleId) => '/module/$moduleId/vocabulary';
  static String reading(int moduleId) => '/module/$moduleId/reading';
  static String practice(int moduleId) => '/module/$moduleId/practice';
  static String posttest(int moduleId) => '/module/$moduleId/posttest';
  static String result(int moduleId) => '/module/$moduleId/result';
  static String history(int moduleId) => '/module/$moduleId/history';
}

GoRouter createAppRouter() => GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(path: AppRoutes.root, redirect: (context, state) => AppRoutes.home),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) =>
          const DevelopmentPlaceholderPage(destination: RootDestination.home),
    ),
    GoRoute(
      path: AppRoutes.modules,
      builder: (context, state) => const DevelopmentPlaceholderPage(
        destination: RootDestination.modules,
      ),
    ),
    GoRoute(
      path: AppRoutes.progress,
      builder: (context, state) => const DevelopmentPlaceholderPage(
        destination: RootDestination.progress,
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const DevelopmentPlaceholderPage(
        destination: RootDestination.profile,
      ),
    ),
  ],
);

enum RootDestination { home, modules, progress, profile }

class DevelopmentPlaceholderPage extends StatelessWidget {
  const DevelopmentPlaceholderPage({required this.destination, super.key});

  final RootDestination destination;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final labels = [
      localizations.navHome,
      localizations.navModules,
      localizations.navProgress,
      localizations.navProfile,
    ];
    final routes = [
      AppRoutes.home,
      AppRoutes.modules,
      AppRoutes.progress,
      AppRoutes.profile,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(localizations.appName)),
      body: Center(
        child: Text(
          labels[destination.index],
          key: const Key('development-placeholder-title'),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: destination.index,
        onDestinationSelected: (index) => context.go(routes[index]),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: labels[0],
          ),
          NavigationDestination(
            icon: const Icon(Icons.layers_outlined),
            selectedIcon: const Icon(Icons.layers),
            label: labels[1],
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: labels[2],
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: labels[3],
          ),
        ],
      ),
    );
  }
}
