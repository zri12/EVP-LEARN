import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../data/providers/database_providers.dart';
import '../../../domain/models/module_content.dart';
import '../../../l10n/app_localizations.dart';
import '../../learning/providers/current_attempt_provider.dart';
import '../../learning/providers/learning_providers.dart';
import '../../modules/presentation/widgets/module_card.dart';
import '../providers/practice_session_provider.dart';

class PracticePage extends ConsumerWidget {
  const PracticePage({required this.moduleId, super.key});
  final String moduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(learningModuleProvider(moduleId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (_, _) => Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.contentUnavailable),
            ),
          ),
          data: (module) => module == null
              ? Scaffold(
                  body: Center(
                    child: Text(
                      AppLocalizations.of(context)!.contentUnavailable,
                    ),
                  ),
                )
              : _PracticeBody(module: module),
        );
  }
}

class _PracticeBody extends ConsumerWidget {
  const _PracticeBody({required this.module});
  final LearningModuleContent module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = PracticeSessionKey(
      moduleId: module.metadata.id,
      activities: module.practices,
    );
    final state = ref.watch(practiceSessionProvider(key));
    final controller = ref.read(practiceSessionProvider(key).notifier);
    if (!controller.isPersistenceAttached) {
      unawaited(() async {
        final active = await ref
            .read(attemptRepositoryProvider)
            .getCurrentAttempt(module.metadata.number);
        if (active != null && !controller.isPersistenceAttached) {
          controller.attachPersistence(
            ref.read(attemptRepositoryProvider),
            active.id,
          );
        }
      }());
    }
    final l10n = AppLocalizations.of(context)!;
    if (state.summaryVisible) {
      return _PracticeSummary(module: module, state: state);
    }
    final activity = state.currentActivity;
    final result = state.currentResult;
    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          button: true,
          label: l10n.back,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: l10n.back,
            onPressed: () => context.pop(),
          ),
        ),
        title: Text(l10n.interactivePractice),
      ),
      body: AppScrollablePage(
        children: [
          Text(
            module.metadata.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${l10n.activity} ${state.currentActivityIndex + 1} ${l10n.ofLabel} 3',
            key: const Key('practice-progress'),
          ),
          const SizedBox(height: AppSpacing.md),
          LinearProgressIndicator(value: (state.currentActivityIndex + 1) / 3),
          const SizedBox(height: AppSpacing.lg),
          Text(
            activity.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(activity.instruction),
          const SizedBox(height: AppSpacing.lg),
          if (activity.kind == PracticeKind.match)
            _MatchingActivity(
              activity: activity,
              state: state,
              controller: controller,
            )
          else
            _SequenceActivity(
              activity: activity,
              state: state,
              controller: controller,
            ),
          const SizedBox(height: AppSpacing.lg),
          _PracticeCompletionHint(state: state),
          const SizedBox(height: AppSpacing.md),
          if (result != null) _ActivityResultCard(result: result),
          if (result == null) ...[
            FilledButton(
              key: const Key('practice-check'),
              onPressed: state.isReadyForCheck
                  ? () async {
                      final repository = ref.read(attemptRepositoryProvider);
                      final activeAttempt = await repository.getCurrentAttempt(
                        int.parse(
                          module.metadata.id.replaceFirst('module_', ''),
                        ),
                      );
                      if (activeAttempt != null) {
                        controller.attachPersistence(
                          repository,
                          activeAttempt.id,
                        );
                      }
                      controller.checkCurrentActivity();
                      final freshState = ref.read(practiceSessionProvider(key));
                      if (freshState.isComplete) {
                        ref
                            .read(
                              currentAttemptProvider(
                                module.metadata.id,
                              ).notifier,
                            )
                            .setPractice(freshState.practiceSummary!);
                      }
                    }
                  : null,
              child: Text(l10n.checkAnswers),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              key: const Key('practice-reset'),
              onPressed: controller.resetCurrentActivity,
              child: Text(l10n.resetActivity),
            ),
          ] else if (state.currentActivityIndex < 2)
            FilledButton(
              key: const Key('practice-next'),
              onPressed: controller.nextActivity,
              child: Text(l10n.nextActivity),
            )
          else
            FilledButton(
              key: const Key('practice-summary'),
              onPressed: () {
                final summary = ref
                    .read(practiceSessionProvider(key))
                    .practiceSummary;
                if (summary != null) {
                  ref
                      .read(currentAttemptProvider(module.metadata.id).notifier)
                      .setPractice(summary);
                  controller.openSummary();
                }
              },
              child: Text(l10n.practiceSummary),
            ),
        ],
      ),
    );
  }
}

class _MatchingActivity extends StatelessWidget {
  const _MatchingActivity({
    required this.activity,
    required this.state,
    required this.controller,
  });
  final PracticeDefinition activity;
  final PracticeSessionState state;
  final PracticeSessionController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.matchSources, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ...activity.sourceItems.map((item) {
          final pairedTarget = state.pairings[item.id];
          final selected = state.selectedSourceId == item.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Semantics(
              label:
                  '${item.label}. ${selected
                      ? l10n.selected
                      : pairedTarget == null
                      ? l10n.unpaired
                      : l10n.paired}. ${l10n.dragSourceHint}',
              button: true,
              child: LongPressDraggable<String>(
                data: item.id,
                maxSimultaneousDrags: state.currentResult == null ? 1 : 0,
                feedback: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 290,
                    child: _MatchCard(
                      label: item.label,
                      selected: true,
                      icon: Icons.drag_indicator_rounded,
                    ),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: .35,
                  child: _MatchCard(
                    label: item.label,
                    selected: selected,
                    icon: Icons.drag_indicator_rounded,
                  ),
                ),
                child: InkWell(
                  key: Key('practice-source-${item.id}'),
                  onTap: () => controller.selectSource(item.id),
                  child: _MatchCard(
                    label: item.label,
                    selected: selected,
                    icon: Icons.drag_indicator_rounded,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.matchTargets, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ...activity.targetItems.map((item) {
          final pairedEntries = state.pairings.entries
              .where((entry) => entry.value == item.id)
              .toList();
          final pairedSource = pairedEntries.isEmpty
              ? null
              : pairedEntries.first.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Semantics(
              button: true,
              label:
                  '${item.label}. ${pairedSource == null ? l10n.unpaired : l10n.paired}. ${l10n.dropTargetHint}',
              child: DragTarget<String>(
                key: Key('practice-target-${item.id}'),
                onWillAcceptWithDetails: (details) =>
                    state.currentResult == null && details.data != item.id,
                onAcceptWithDetails: (details) =>
                    controller.pair(details.data, item.id),
                builder: (context, candidates, rejected) => InkWell(
                  onTap: state.selectedSourceId == null
                      ? null
                      : () => controller.pair(state.selectedSourceId!, item.id),
                  child: _MatchCard(
                    label: item.label,
                    selected: candidates.isNotEmpty,
                    paired: pairedSource != null,
                    icon: Icons.input_rounded,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${l10n.paired}: ${state.pairings.length}/${activity.sourceItems.length}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PracticeCompletionHint extends StatelessWidget {
  const _PracticeCompletionHint({required this.state});
  final PracticeSessionState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(
          state.isReadyForCheck
              ? Icons.check_circle_outline_rounded
              : Icons.info_outline_rounded,
          color: state.isReadyForCheck
              ? AppColors.success
              : AppColors.mutedText,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            state.isReadyForCheck
                ? l10n.practiceReadyToCheck
                : l10n.practiceCompletionStatus(
                    state.currentItemCount,
                    state.currentTotalItems,
                  ),
          ),
        ),
      ],
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({
    required this.label,
    required this.icon,
    this.selected = false,
    this.paired = false,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final bool paired;
  @override
  Widget build(BuildContext context) => Card(
    color: selected
        ? AppColors.primary.withValues(alpha: .12)
        : paired
        ? AppColors.softBlue
        : AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.card,
      side: BorderSide(color: selected ? AppColors.primary : AppColors.border),
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? AppColors.primary : AppColors.mutedText,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(label)),
            if (paired)
              const Icon(
                Icons.link_rounded,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    ),
  );
}

class _SequenceActivity extends StatelessWidget {
  const _SequenceActivity({
    required this.activity,
    required this.state,
    required this.controller,
  });
  final PracticeDefinition activity;
  final PracticeSessionState state;
  final PracticeSessionController controller;
  @override
  Widget build(BuildContext context) {
    final items = {for (final item in activity.sequenceItems) item.id: item};
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: true,
      onReorder: controller.reorder,
      children: [
        for (final id in state.sequenceOrder)
          Card(
            key: ValueKey(id),
            child: Semantics(
              button: true,
              label:
                  '${items[id]!.label}. ${AppLocalizations.of(context)!.reorderHint}',
              child: ListTile(
                leading: const Icon(Icons.drag_handle_rounded),
                title: Text(items[id]!.label),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActivityResultCard extends StatelessWidget {
  const _ActivityResultCard({required this.result});
  final PracticeActivityResult result;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      key: const Key('practice-activity-result'),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                '${l10n.correctAnswers}: ${result.correctItems}/${result.totalItems}',
              ),
            ),
            Text(
              '${result.score}/10',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticeSummary extends ConsumerWidget {
  const _PracticeSummary({required this.module, required this.state});
  final LearningModuleContent module;
  final PracticeSessionState state;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final summary = state.practiceSummary!;
    final visual = moduleVisualFor(module.metadata.number);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.practiceSummary)),
      body: AppScrollablePage(
        children: [
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.practiceComplete,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: visual.tint,
              borderRadius: AppRadius.heroCard,
              border: Border.all(color: visual.accent.withValues(alpha: .16)),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: visual.accent, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      '${summary.totalScore}',
                      style: TextStyle(
                        color: visual.accent,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.practiceTotal,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text('/30', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...summary.activities.indexed.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _PracticeSummaryActivityCard(
                label: '${l10n.activity} ${entry.$1 + 1}',
                score: entry.$2.score,
                accent: visual.accent,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.practiceTotal}: ${summary.totalScore}/30',
            key: const Key('practice-total'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            key: const Key('practice-to-posttest'),
            onPressed: () =>
                context.go(AppRoutes.posttest(module.metadata.number)),
            child: Text(l10n.continueToPosttest),
          ),
        ],
      ),
    );
  }
}

class _PracticeSummaryActivityCard extends StatelessWidget {
  const _PracticeSummaryActivityCard({
    required this.label,
    required this.score,
    required this.accent,
  });
  final String label;
  final int score;
  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.card,
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline_rounded, color: accent),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label)),
        Text(
          '$score/10',
          style: TextStyle(color: accent, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
