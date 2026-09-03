import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../data/content/root_module_catalog.dart';
import '../../root/providers/root_dashboard_provider.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/module_card.dart';

class ModulesPage extends ConsumerWidget {
  const ModulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dashboard = ref.watch(rootDashboardProvider);
    return AppScrollablePage(
      children: [
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.learningModules,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.chooseModule, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpacing.xl),
        ...rootModules.expand(
          (module) => [
            ModuleCard(
              module: module,
              progress: dashboard.progressFor(module.id),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ],
    );
  }
}
