import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_page.dart';
import '../features/assessment/presentation/assessment_pages.dart';
import '../features/learning/presentation/learning_pages.dart';
import '../features/modules/presentation/modules_page.dart';
import '../features/profile/presentation/profile_page.dart';
import '../features/practice/presentation/practice_pages.dart';
import '../features/progress/presentation/progress_page.dart';
import '../features/root/presentation/root_app_shell.dart';
import '../features/splash/presentation/splash_page.dart';
import '../features/support/presentation/support_pages.dart';
import '../domain/models/assessment_result.dart';

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
  static String pretestResult(int moduleId) =>
      '/module/$moduleId/pretest/result';
  static String theory(int moduleId) => '/module/$moduleId/theory';
  static String vocabulary(int moduleId) => '/module/$moduleId/vocabulary';
  static String reading(int moduleId, [String? readingId]) =>
      '/module/$moduleId/reading${readingId == null ? '' : '/$readingId'}';
  static String practice(int moduleId) => '/module/$moduleId/practice';
  static String posttest(int moduleId) => '/module/$moduleId/posttest';
  static String posttestResult(int moduleId) =>
      '/module/$moduleId/posttest/result';
  static String finalResult(int moduleId) => '/module/$moduleId/final';
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
    GoRoute(
      path: '/module/:moduleId',
      builder: (context, state) =>
          ModuleOverviewPage(moduleId: state.pathParameters['moduleId']!),
      routes: [
        GoRoute(
          path: 'objectives',
          builder: (context, state) => LearningObjectivesPage(
            moduleId: state.pathParameters['moduleId']!,
          ),
        ),
        GoRoute(
          path: 'pretest',
          builder: (context, state) => AssessmentPage(
            moduleId: state.pathParameters['moduleId']!,
            type: AssessmentType.pretest,
          ),
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) => AssessmentResultPage(
                moduleId: state.pathParameters['moduleId']!,
                type: AssessmentType.pretest,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'theory',
          builder: (context, state) =>
              TheoryPage(moduleId: state.pathParameters['moduleId']!),
        ),
        GoRoute(
          path: 'vocabulary',
          builder: (context, state) =>
              VocabularyPage(moduleId: state.pathParameters['moduleId']!),
        ),
        GoRoute(
          path: 'reading/:readingId',
          builder: (context, state) => ReadingPage(
            moduleId: state.pathParameters['moduleId']!,
            readingId: state.pathParameters['readingId']!,
          ),
        ),
        GoRoute(
          path: 'practice',
          builder: (context, state) =>
              PracticePage(moduleId: state.pathParameters['moduleId']!),
        ),
        GoRoute(
          path: 'posttest',
          builder: (context, state) => AssessmentPage(
            moduleId: state.pathParameters['moduleId']!,
            type: AssessmentType.posttest,
            enforcePracticeGuard: true,
          ),
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) => AssessmentResultPage(
                moduleId: state.pathParameters['moduleId']!,
                type: AssessmentType.posttest,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'final',
          builder: (context, state) =>
              FinalResultPage(moduleId: state.pathParameters['moduleId']!),
        ),
      ],
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
