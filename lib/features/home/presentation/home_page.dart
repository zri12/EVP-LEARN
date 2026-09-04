import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../core/widgets/app_page.dart';
import '../../../data/content/root_module_catalog.dart';
import '../../../features/root/providers/root_dashboard_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../modules/presentation/widgets/module_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dashboard = ref.watch(rootDashboardProvider);

    return AppScrollablePage(
      children: [
        _HomeHero(l10n: l10n),
        const SizedBox(height: AppSpacing.md),
        if (dashboard.resume == null)
          Semantics(
            button: true,
            label: l10n.exploreModules,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.modules),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(l10n.exploreModules),
              ),
            ),
          )
        else
          _ContinueLearningCard(
            moduleId: dashboard.resume!.moduleId,
            progress: dashboard.resume!.percent,
            stageLabel: _resumeStageLabel(l10n, dashboard.resume!.stageLabel),
            onTap: () => context.go(
              _resumeRoute(
                dashboard.resume!.moduleId,
                dashboard.resume!.stageLabel,
                dashboard.resume!.lastRouteKey,
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.xl),
        _SectionHeader(
          title: l10n.learningProgress,
          subtitle: dashboard.overallPercent == 0 ? l10n.noProgressYet : null,
          trailing: l10n.modulesComplete(dashboard.completedModules),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppProgressBar(value: dashboard.overallPercent),
        const SizedBox(height: AppSpacing.xxl),
        _SectionHeader(
          title: l10n.yourModules,
          actionLabel: l10n.seeAll,
          onAction: () => context.go(AppRoutes.modules),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 198,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: rootModules.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final module = rootModules[index];
              final visual = moduleVisualFor(module.id);
              return _ModulePreviewCard(
                moduleId: module.id,
                title: module.title,
                progress: dashboard.progressFor(module.id).percent,
                accent: visual.accent,
                tint: visual.tint,
                onTap: () => context.push(AppRoutes.moduleOverview(module.id)),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _SectionHeader(title: l10n.quickAccess),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _QuickAccessCard(
                icon: Icons.help_outline_rounded,
                label: l10n.howToUse,
                onTap: () => context.push(AppRoutes.guide),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAccessCard(
                icon: Icons.track_changes_outlined,
                label: l10n.learningOutcomes,
                onTap: () => context.push(AppRoutes.outcomes),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        borderRadius: AppRadius.heroCard,
        gradient: LinearGradient(
          colors: [AppColors.heroStart, AppColors.heroEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.brandDescriptor,
            style: const TextStyle(
              color: Color(0xFFBFDBFE),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.readyToLearn,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 27,
              height: 1.15,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.startJourney,
            style: const TextStyle(
              color: Color(0xFFDBEAFE),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ShelfLine(width: 66),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 58,
                  height: 58,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset('assets/images/branding/evp-icon.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelfLine extends StatelessWidget {
  const _ShelfLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .35),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
  final String? trailing;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
              ],
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              trailing!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

class _ModulePreviewCard extends StatelessWidget {
  const _ModulePreviewCard({
    required this.moduleId,
    required this.title,
    required this.progress,
    required this.accent,
    required this.tint,
    required this.onTap,
  });

  final int moduleId;
  final String title;
  final int progress;
  final Color accent;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 208,
      key: Key('home-module-preview-$moduleId'),
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: AppRadius.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: AppRadius.small,
                  ),
                  child: Icon(moduleVisualFor(moduleId).icon, color: accent),
                ),
                const Spacer(),
                Text(
                  l10n.moduleLabel(moduleId),
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                AppProgressBar(value: progress, color: accent, height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Container(
            constraints: const BoxConstraints(minHeight: 112),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: AppRadius.card,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard({
    required this.moduleId,
    required this.progress,
    required this.stageLabel,
    required this.onTap,
  });

  final int moduleId;
  final int progress;
  final String stageLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: AppRadius.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.continueLearning.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: .8,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.moduleLabel(moduleId),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(stageLabel, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSpacing.sm),
            AppProgressBar(value: progress),
          ],
        ),
      ),
    );
  }
}

String _resumeRoute(int moduleId, String stage, String? lastRouteKey) {
  if (lastRouteKey != null && lastRouteKey.startsWith('/module/$moduleId/')) {
    return lastRouteKey;
  }
  return switch (stage) {
    'objectives' => AppRoutes.objectives(moduleId),
    'pretest' => AppRoutes.pretest(moduleId),
    'pretest_result' => AppRoutes.pretestResult(moduleId),
    'theory' => AppRoutes.theory(moduleId),
    'vocabulary' => AppRoutes.vocabulary(moduleId),
    'reading' => AppRoutes.reading(moduleId, 'm${moduleId}_reading_01'),
    'practice' => AppRoutes.practice(moduleId),
    'posttest' => AppRoutes.posttest(moduleId),
    'result' => AppRoutes.finalResult(moduleId),
    _ => AppRoutes.moduleOverview(moduleId),
  };
}

String _resumeStageLabel(AppLocalizations l10n, String stage) =>
    switch (stage) {
      'objectives' => l10n.learningObjectives,
      'pretest' => l10n.pretest,
      'pretest_result' => l10n.pretestResult,
      'theory' => l10n.theory,
      'vocabulary' => l10n.vocabularyPreview,
      'reading' => l10n.reading,
      'practice' => l10n.interactivePractice,
      'posttest' => l10n.posttest,
      'result' => l10n.finalScore,
      _ => l10n.moduleOverview,
    };
