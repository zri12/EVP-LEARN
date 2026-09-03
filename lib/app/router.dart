import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_page.dart';
import '../features/modules/presentation/modules_page.dart';
import '../features/profile/presentation/profile_page.dart';
import '../features/progress/presentation/progress_page.dart';
import '../features/root/presentation/root_app_shell.dart';
import '../features/splash/presentation/splash_page.dart';
import '../features/support/presentation/support_pages.dart';

abstract final class AppRoutes {
  static const root = '/';
  static const home = '/home';
  static const modules = '/modules';
  static const progress = '/progress';
  static const profile = '/profile';
  static const guide = '/guide';
  static const outcomes = '/outcomes';

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
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(
      path: AppRoutes.root,
      builder: (context, state) => const SplashPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootAppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.modules,
              builder: (context, state) => const ModulesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.progress,
              builder: (context, state) => const ProgressPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.guide,
      builder: (context, state) => const GuidePage(),
    ),
    GoRoute(
      path: AppRoutes.outcomes,
      builder: (context, state) => const OutcomesPage(),
    ),
  ],
);
