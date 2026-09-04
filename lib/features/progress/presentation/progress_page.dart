import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../data/content/root_module_catalog.dart';
import '../../../domain/models/learning_models.dart';
import '../../../domain/models/root_module.dart';
import '../../modules/presentation/widgets/module_card.dart';
import '../../root/providers/root_dashboard_provider.dart';
import '../../../l10n/app_localizations.dart';

class ProgressPage extends ConsumerWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dashboard = ref.watch(rootDashboardProvider);
    return AppScrollablePage(
      children: [
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.yourProgress,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.noProgressYet, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpacing.xl),
        Container(
          key: const Key('overall-progress-card'),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: const BoxDecoration(
            color: AppColors.softBlue,
            borderRadius: AppRadius.card,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.overallProgress.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.modulesComplete(dashboard.completedModules),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${dashboard.overallPercent}%',
                key: const Key('overall-progress-value'),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppProgressBar(value: dashboard.overallPercent),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.moduleProgress,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...rootModules.map(
          (module) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _ProgressModuleEntry(
              module: module,
              progress: dashboard.progressFor(module.id),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressModuleEntry extends StatelessWidget {
  const _ProgressModuleEntry({required this.module, required this.progress});

  final RootModule module;
  final RootModuleProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visual = moduleVisualFor(module.id);
    final isCompleted = progress.status == ModuleStatus.completed;
    return Semantics(
      label:
          '${l10n.moduleLabel(module.id)} ${module.title}. '
          '${statusLabel(l10n, progress.status)} ${progress.percent}%.',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: AppRadius.card,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: visual.tint,
                borderRadius: AppRadius.small,
              ),
              child: Icon(visual.icon, color: visual.accent),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l10n.moduleLabel(module.id)} · ${module.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        isCompleted
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 14,
                        color: visual.accent,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          statusLabel(l10n, progress.status),
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (progress.latestScore != null ||
                      progress.bestScore != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${l10n.latestScore}: ${progress.latestScore ?? '—'}  ·  '
                      '${l10n.bestScore}: ${progress.bestScore ?? '—'}',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xs),
                  AppProgressBar(
                    value: progress.percent,
                    color: visual.accent,
                    height: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${progress.percent}%',
              style: TextStyle(
                color: visual.accent,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
