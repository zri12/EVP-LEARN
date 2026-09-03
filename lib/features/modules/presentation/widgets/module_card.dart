import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_progress_bar.dart';
import '../../../../domain/models/learning_models.dart';
import '../../../../domain/models/root_module.dart';
import '../../../../l10n/app_localizations.dart';

class ModuleVisual {
  const ModuleVisual({
    required this.accent,
    required this.tint,
    required this.icon,
  });

  final Color accent;
  final Color tint;
  final IconData icon;
}

ModuleVisual moduleVisualFor(int moduleId) => switch (moduleId) {
  1 => const ModuleVisual(
    accent: AppColors.module1,
    tint: AppColors.module1Tint,
    icon: Icons.menu_book_rounded,
  ),
  2 => const ModuleVisual(
    accent: AppColors.module2,
    tint: AppColors.module2Tint,
    icon: Icons.storefront_outlined,
  ),
  _ => const ModuleVisual(
    accent: AppColors.module3,
    tint: AppColors.module3Tint,
    icon: Icons.point_of_sale_outlined,
  ),
};

String statusLabel(AppLocalizations l10n, ModuleStatus status) =>
    switch (status) {
      ModuleStatus.notStarted => l10n.notStarted,
      ModuleStatus.inProgress => l10n.inProgress,
      ModuleStatus.completed => l10n.completed,
    };

String moduleCtaLabel(AppLocalizations l10n, ModuleStatus status) =>
    switch (status) {
      ModuleStatus.notStarted => l10n.startModule,
      ModuleStatus.inProgress => l10n.continueModule,
      ModuleStatus.completed => l10n.reviewModule,
    };

class ModuleCard extends StatelessWidget {
  const ModuleCard({required this.module, required this.progress, super.key});

  final RootModule module;
  final RootModuleProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visual = moduleVisualFor(module.id);
    final status = statusLabel(l10n, progress.status);
    final cta = moduleCtaLabel(l10n, progress.status);

    return Semantics(
      label: '${l10n.moduleLabel(module.id)}. ${module.title}. $status.',
      child: Container(
        key: Key('module-card-${module.id}'),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: AppRadius.heroCard,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: visual.tint,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      l10n.moduleLabel(module.id),
                      style: TextStyle(
                        color: visual.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    progress.status == ModuleStatus.completed
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 15,
                    color: visual.accent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                module.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.xs,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(
                module.subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              height: 148,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: visual.tint,
                borderRadius: AppRadius.card,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                module.assetPath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  AppProgressBar(value: progress.percent, color: visual.accent),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Text(
                        l10n.percentComplete(progress.percent),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Semantics(
                        label: '$cta ${l10n.moduleLabel(module.id)}',
                        child: Text(
                          cta,
                          style: TextStyle(
                            color: visual.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 17,
                        color: visual.accent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
