import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../data/content/root_module_catalog.dart';
import '../../../data/repositories/persistence_repository.dart';
import '../../../domain/models/learning_models.dart';
import '../../../domain/models/root_module.dart';
import '../../../l10n/app_localizations.dart';
import '../../modules/presentation/widgets/module_card.dart';
import '../../root/providers/root_dashboard_provider.dart';
import '../providers/progress_history_provider.dart';

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
          l10n.progressTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${l10n.modulesCompletedLabel}: ${dashboard.completedModules} / 3',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        _OverallProgressCard(dashboard: dashboard),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.moduleProgress,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...rootModules.map(
          (module) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _ProgressModuleCard(
              module: module,
              progress: dashboard.progressFor(module.id),
            ),
          ),
        ),
      ],
    );
  }
}

class _OverallProgressCard extends StatelessWidget {
  const _OverallProgressCard({required this.dashboard});
  final RootDashboardState dashboard;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      label:
          '${l10n.overallProgress}: ${dashboard.overallPercent}%. ${l10n.modulesComplete(dashboard.completedModules)}',
      child: Container(
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
    );
  }
}

class _ProgressModuleCard extends StatelessWidget {
  const _ProgressModuleCard({required this.module, required this.progress});
  final RootModule module;
  final RootModuleProgress progress;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visual = moduleVisualFor(module.id);
    final status = statusLabel(l10n, progress.status);
    final scoreSummary = [
      if (progress.latestScore != null)
        '${l10n.latestScore} ${progress.latestScore}',
      if (progress.bestScore != null) '${l10n.bestScore} ${progress.bestScore}',
    ].join('. ');
    return Semantics(
      button: true,
      label:
          '${l10n.moduleLabel(module.id)} ${module.title}. $status ${progress.percent}%. $scoreSummary',
      child: InkWell(
        key: Key('progress-module-card-${module.id}'),
        borderRadius: AppRadius.card,
        onTap: () => context.push(AppRoutes.progressModule(module.id)),
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
              Row(
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
              const SizedBox(height: AppSpacing.sm),
              Text(module.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.xs),
              AppProgressBar(
                value: progress.percent,
                color: visual.accent,
                height: 5,
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Text(
                    l10n.percentComplete(progress.percent),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: visual.accent,
                  ),
                ],
              ),
              if (progress.latestScore != null ||
                  progress.bestScore != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${l10n.latestScore}: ${progress.latestScore ?? '—'}  ·  ${l10n.bestScore}: ${progress.bestScore ?? '—'}',
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleProgressDetailPage extends ConsumerWidget {
  const ModuleProgressDetailPage({required this.moduleId, super.key});
  final String moduleId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(moduleId);
    final module = id == null ? null : _moduleFor(id);
    final l10n = AppLocalizations.of(context)!;
    if (module == null || id == null) {
      return _UnavailablePage(title: l10n.progressUnavailable);
    }
    final snapshot = ref.watch(moduleProgressSnapshotProvider(id));
    return Scaffold(
      appBar: AppBar(title: Text(module.title)),
      body: snapshot.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _UnavailablePage(title: l10n.progressUnavailable),
        data: (data) => _DetailBody(module: module, snapshot: data),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.module, required this.snapshot});
  final RootModule module;
  final ModuleProgressSnapshot snapshot;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final latest = snapshot.latestAttempt;
    final best = snapshot.bestScore;
    final active = snapshot.activeAttempt;
    final progress = ref
        .watch(rootDashboardProvider)
        .progressFor(module.id)
        .percent;
    return AppScrollablePage(
      children: [
        Text(module.title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          active != null
              ? l10n.inProgress
              : (snapshot.hasHistory ? l10n.completed : l10n.notStarted),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        AppProgressBar(
          value: active != null ? progress : (snapshot.hasHistory ? 100 : 0),
          color: moduleVisualFor(module.id).accent,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (latest != null || best != null)
          Row(
            children: [
              if (latest != null)
                Expanded(
                  child: _ScoreTile(
                    label: l10n.latestScore,
                    score: latest.finalScore,
                  ),
                ),
              if (latest != null && best != null)
                const SizedBox(width: AppSpacing.sm),
              if (best != null)
                Expanded(
                  child: _ScoreTile(label: l10n.bestScore, score: best),
                ),
            ],
          ),
        if (active != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _ActiveAttemptCard(attempt: active, module: module),
        ],
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.evaluationHistory,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (snapshot.completedAttempts.isEmpty)
          _EmptyHistory(module: module, hasActive: active != null)
        else
          ...snapshot.completedAttempts.map(
            (attempt) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _HistoryCard(
                attempt: attempt,
                latest: latest?.id == attempt.id,
                best: attempt.finalScore == best,
                module: module,
              ),
            ),
          ),
      ],
    );
  }
}

class _ScoreTile extends StatelessWidget {
  const _ScoreTile({required this.label, required this.score});
  final String label;
  final double? score;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: const BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.card,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          score == null ? '—' : '${score!.round()}/100',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
  );
}

class _ActiveAttemptCard extends StatelessWidget {
  const _ActiveAttemptCard({required this.attempt, required this.module});
  final LearningAttemptRecord attempt;
  final RootModule module;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: moduleVisualFor(module.id).tint,
        borderRadius: AppRadius.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.currentAttemptTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${l10n.activeStage}: ${_stageLabel(l10n, attempt.currentStage)}',
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(
            onPressed: () => context.push(_resumeRoute(module.id, attempt)),
            child: Text(l10n.continueLearningAction),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.attempt,
    required this.latest,
    required this.best,
    required this.module,
  });
  final LearningAttemptRecord attempt;
  final bool latest;
  final bool best;
  final RootModule module;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = attempt.passed == true
        ? l10n.passedStatus
        : l10n.needsReviewStatus;
    return Semantics(
      button: true,
      label:
          '${l10n.attemptLabel(attempt.attemptNumber)} ${_score(l10n, attempt.finalScore)}. $status',
      child: InkWell(
        key: Key('history-attempt-${attempt.id}'),
        onTap: () =>
            context.push(AppRoutes.attemptDetail(module.id, attempt.id)),
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
              Row(
                children: [
                  Text(
                    l10n.attemptLabel(attempt.attemptNumber),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    _score(l10n, attempt.finalScore),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${l10n.completedOn}: ${_formatDate(attempt.completedAt!, Localizations.localeOf(context))}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                children: [
                  if (latest)
                    _Badge(label: l10n.latestBadge, color: AppColors.primary),
                  if (best)
                    _Badge(label: l10n.bestBadge, color: AppColors.module3),
                  _Badge(
                    label: status,
                    color: attempt.passed == true
                        ? AppColors.success
                        : AppColors.warning,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${l10n.pretestRawLabel}: ${_score(l10n, attempt.pretestRaw)} · ${l10n.practiceRawLabel}: ${attempt.practiceTotal.round()}/30 · ${l10n.posttestRawLabel}: ${_score(l10n, attempt.posttestRaw)} · ${l10n.learningGainLabel}: ${_gain(l10n, attempt.learningGain)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Chip(
    label: Text(
      label,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
    ),
    backgroundColor: color.withAlpha(25),
    side: BorderSide.none,
    visualDensity: VisualDensity.compact,
  );
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.module, required this.hasActive});
  final RootModule module;
  final bool hasActive;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.noEvaluationResults,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (!hasActive) ...[
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.moduleOverview(module.id)),
            child: Text(l10n.startModule),
          ),
        ],
      ],
    );
  }
}

class AttemptDetailPage extends ConsumerWidget {
  const AttemptDetailPage({
    required this.moduleId,
    required this.attemptId,
    super.key,
  });
  final String moduleId;
  final String attemptId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(moduleId);
    final module = id == null ? null : _moduleFor(id);
    final l10n = AppLocalizations.of(context)!;
    if (module == null) {
      return _UnavailablePage(title: l10n.progressUnavailable);
    }
    final state = ref.watch(attemptDetailProvider(attemptId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.resultDetails)),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _UnavailablePage(title: l10n.progressUnavailable),
        data: (attempt) {
          if (attempt == null ||
              attempt.moduleId != id ||
              !attempt.isCompleted ||
              attempt.completedAt == null ||
              attempt.pretestRaw == null ||
              attempt.posttestRaw == null ||
              attempt.posttestWeighted == null ||
              attempt.finalScore == null ||
              attempt.learningGain == null ||
              attempt.passed == null) {
            return _UnavailablePage(title: l10n.progressUnavailable);
          }
          return _AttemptBody(attempt: attempt, module: module);
        },
      ),
    );
  }
}

class _AttemptBody extends StatelessWidget {
  const _AttemptBody({required this.attempt, required this.module});
  final LearningAttemptRecord attempt;
  final RootModule module;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = attempt.passed == true
        ? l10n.passedStatus
        : l10n.needsReviewStatus;
    return AppScrollablePage(
      children: [
        Text(module.title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.attemptLabel(attempt.attemptNumber),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: const BoxDecoration(
            color: AppColors.softBlue,
            borderRadius: AppRadius.card,
          ),
          child: Column(
            children: [
              Text(
                l10n.finalScoreLabel,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                _score(l10n, attempt.finalScore),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(status, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Metric(
          label: l10n.pretestRawLabel,
          value: _score(l10n, attempt.pretestRaw),
        ),
        _Metric(
          label: l10n.practiceRawLabel,
          value: '${attempt.practiceTotal.round()}/30',
        ),
        _Metric(
          label: l10n.posttestRawLabel,
          value: _score(l10n, attempt.posttestRaw),
        ),
        _Metric(
          label: l10n.posttestWeightedLabel,
          value: '${attempt.posttestWeighted?.round() ?? 0}/70',
        ),
        _Metric(
          label: l10n.learningGainLabel,
          value: _gain(l10n, attempt.learningGain),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${l10n.completedOn}: ${_formatDate(attempt.completedAt!, Localizations.localeOf(context))}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

class _UnavailablePage extends StatelessWidget {
  const _UnavailablePage({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(title, textAlign: TextAlign.center),
    ),
  );
}

RootModule? _moduleFor(int id) =>
    rootModules.where((module) => module.id == id).firstOrNull;
String _score(AppLocalizations l10n, double? value) =>
    value == null ? l10n.notAvailable : '${value.round()}/100';
String _gain(AppLocalizations l10n, double? value) => value == null
    ? l10n.notAvailable
    : (value > 0 ? '+${value.round()}' : value.round().toString());
String _formatDate(DateTime date, Locale locale) =>
    DateFormat.yMMMd(locale.toString()).format(date);
String _resumeRoute(int moduleId, LearningAttemptRecord attempt) {
  final route = attempt.lastRouteKey;
  if (route != null && route.startsWith('/module/$moduleId')) return route;
  return switch (attempt.currentStage) {
    PersistedLearningStage.objectives => AppRoutes.objectives(moduleId),
    PersistedLearningStage.pretest => AppRoutes.pretest(moduleId),
    PersistedLearningStage.theory => AppRoutes.theory(moduleId),
    PersistedLearningStage.vocabulary => AppRoutes.vocabulary(moduleId),
    PersistedLearningStage.reading => AppRoutes.reading(
      moduleId,
      'm${moduleId}_reading_01',
    ),
    PersistedLearningStage.practice => AppRoutes.practice(moduleId),
    PersistedLearningStage.posttest => AppRoutes.posttest(moduleId),
    _ => AppRoutes.moduleOverview(moduleId),
  };
}

String _stageLabel(AppLocalizations l10n, String stage) => switch (stage) {
  PersistedLearningStage.objectives => l10n.learningObjectives,
  PersistedLearningStage.pretest => l10n.pretest,
  PersistedLearningStage.theory => l10n.theory,
  PersistedLearningStage.vocabulary => l10n.vocabularyPreview,
  PersistedLearningStage.reading => l10n.reading,
  PersistedLearningStage.practice => l10n.practiceSummary,
  PersistedLearningStage.posttest => l10n.posttest,
  _ => l10n.continueLearningAction,
};
