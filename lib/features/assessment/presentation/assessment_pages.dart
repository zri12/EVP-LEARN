import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../domain/models/assessment_result.dart';
import '../../../domain/models/module_content.dart';
import '../../../domain/scoring/practice_scoring.dart';
import '../../learning/providers/learning_providers.dart';
import '../../learning/providers/current_attempt_provider.dart';
import '../../modules/presentation/widgets/module_card.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/assessment_session_provider.dart';

class AssessmentPage extends ConsumerWidget {
  const AssessmentPage({
    required this.moduleId,
    required this.type,
    this.enforcePracticeGuard = false,
    super.key,
  });
  final String moduleId;
  final AssessmentType type;
  final bool enforcePracticeGuard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(learningModuleProvider(moduleId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (_, __) =>
              const Scaffold(body: Center(child: Text('Content unavailable'))),
          data: (module) => module == null
              ? const Scaffold(body: Center(child: Text('Content unavailable')))
              : _AssessmentBody(
                  module: module,
                  type: type,
                  enforcePracticeGuard: enforcePracticeGuard,
                ),
        );
  }
}

class _AssessmentBody extends ConsumerWidget {
  const _AssessmentBody({
    required this.module,
    required this.type,
    required this.enforcePracticeGuard,
  });
  final LearningModuleContent module;
  final AssessmentType type;
  final bool enforcePracticeGuard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bank = type == AssessmentType.pretest
        ? module.pretest
        : module.posttest;
    final key = AssessmentSessionKey(
      moduleId: module.metadata.id,
      type: type,
      questionBank: bank,
    );
    final state = ref.watch(assessmentSessionProvider(key));
    final controller = ref.read(assessmentSessionProvider(key).notifier);
    final l10n = AppLocalizations.of(context)!;
    if (type == AssessmentType.posttest &&
        enforcePracticeGuard &&
        !ref
            .watch(currentAttemptProvider(module.metadata.id))
            .hasCompletePractice) {
      return _PosttestGuard(moduleId: module.metadata.number);
    }
    final question = state.currentQuestion;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          type == AssessmentType.pretest ? l10n.pretest : l10n.posttest,
        ),
      ),
      body: AppScrollablePage(
        children: [
          Text(
            module.metadata.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${l10n.question} ${state.currentQuestionIndex + 1}/${state.totalQuestions}',
            key: const Key('assessment-progress'),
          ),
          const SizedBox(height: AppSpacing.lg),
          LinearProgressIndicator(
            value: (state.currentQuestionIndex + 1) / state.totalQuestions,
          ),
          const SizedBox(height: AppSpacing.xl),
          Card(
            key: const Key('assessment-question-card'),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.prompt,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...question.options.indexed.map(
                    (entry) => RadioListTile<int>(
                      key: Key('assessment-option-${question.id}-${entry.$1}'),
                      value: entry.$1,
                      groupValue: state.answers[question.id],
                      onChanged: state.isComplete
                          ? null
                          : (value) => controller.selectAnswer(value!),
                      title: Text(entry.$2),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  key: const Key('assessment-previous'),
                  onPressed: state.currentQuestionIndex == 0
                      ? null
                      : controller.previous,
                  child: Text(l10n.previous),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: state.currentQuestionIndex < state.totalQuestions - 1
                    ? FilledButton(
                        key: const Key('assessment-next'),
                        onPressed: controller.next,
                        child: Text(l10n.next),
                      )
                    : FilledButton(
                        key: const Key('assessment-submit'),
                        onPressed:
                            state.isSubmitting ||
                                state.isComplete ||
                                state.unansweredCount > 0
                            ? null
                            : () => _submit(
                                context,
                                ref,
                                controller,
                                state,
                                type,
                              ),
                        child: Text(l10n.submitAnswers),
                      ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              '${l10n.answered}: ${state.answeredCount}  •  ${l10n.unanswered}: ${state.unansweredCount}',
            ),
          ),
          if (state.unansweredCount > 0) ...[
            const SizedBox(height: AppSpacing.xs),
            Center(
              child: Text(
                l10n.answerAllQuestions,
                key: const Key('assessment-incomplete-helper'),
                style: const TextStyle(color: AppColors.error),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
    WidgetRef ref,
    AssessmentSessionController controller,
    AssessmentSessionState state,
    AssessmentType type,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (state.unansweredCount > 0) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.confirmSubmit),
          content: Text(
            l10n.submitConfirmMessage(
              state.answeredCount,
              state.unansweredCount,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.continueAnswering),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(l10n.submitAnswers),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
      return;
    }
    final result = await controller.submit();
    if (result == null || !context.mounted) return;
    final attempt = ref.read(currentAttemptProvider(result.moduleId).notifier);
    if (type == AssessmentType.pretest) {
      attempt.setPretest(result);
    } else {
      attempt.setPosttest(result);
    }
    context.push(
      type == AssessmentType.pretest
          ? AppRoutes.pretestResult(
              int.parse(state.moduleId.replaceFirst('module_', '')),
            )
          : AppRoutes.posttestResult(
              int.parse(state.moduleId.replaceFirst('module_', '')),
            ),
    );
  }
}

class _PosttestGuard extends StatelessWidget {
  const _PosttestGuard({required this.moduleId});
  final int moduleId;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.posttest)),
      body: AppPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.practiceRequiredBeforePosttest,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () => context.go(AppRoutes.practice(moduleId)),
              child: Text(l10n.goToPractice),
            ),
          ],
        ),
      ),
    );
  }
}

class AssessmentResultPage extends ConsumerWidget {
  const AssessmentResultPage({
    required this.moduleId,
    required this.type,
    super.key,
  });
  final String moduleId;
  final AssessmentType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(learningModuleProvider(moduleId))
        .when(
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (_, __) =>
              const Scaffold(body: Center(child: Text('Content unavailable'))),
          data: (module) {
            if (module == null)
              return const Scaffold(
                body: Center(child: Text('Content unavailable')),
              );
            final bank = type == AssessmentType.pretest
                ? module.pretest
                : module.posttest;
            final key = AssessmentSessionKey(
              moduleId: module.metadata.id,
              type: type,
              questionBank: bank,
            );
            final result = ref.watch(assessmentSessionProvider(key)).result;
            if (result == null)
              return AssessmentPage(moduleId: moduleId, type: type);
            final l10n = AppLocalizations.of(context)!;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  type == AssessmentType.pretest
                      ? l10n.pretestResult
                      : l10n.posttestResult,
                ),
              ),
              body: _AssessmentResultView(
                module: module,
                result: result,
                type: type,
              ),
            );
          },
        );
  }
}

class _AssessmentResultView extends StatelessWidget {
  const _AssessmentResultView({
    required this.module,
    required this.result,
    required this.type,
  });
  final LearningModuleContent module;
  final AssessmentResult result;
  final AssessmentType type;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pretest = type == AssessmentType.pretest;
    final accent = moduleVisualFor(module.metadata.number).accent;
    return AppScrollablePage(
      children: [
        const SizedBox(height: AppSpacing.md),
        Text(
          pretest ? l10n.diagnosticResultTitle : l10n.posttestResultTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: .78)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: AppRadius.heroCard,
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F0F172A),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                pretest ? Icons.insights_rounded : Icons.assessment_rounded,
                size: 42,
                color: Colors.white,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${result.rawScore}/100',
                key: const Key('assessment-result-score'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.score,
                style: const TextStyle(color: Color(0xFFE0EAFF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          pretest ? l10n.diagnosticNote : l10n.posttestResult,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _ResultMetric(
                icon: Icons.check_circle_outline_rounded,
                label: l10n.correctAnswers,
                value: '${result.correct}',
                accent: AppColors.success,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ResultMetric(
                icon: Icons.remove_circle_outline_rounded,
                label: l10n.incorrectAnswers,
                value: '${result.incorrect}',
                accent: AppColors.warning,
              ),
            ),
          ],
        ),
        if (!pretest && result.weightedScore != null) ...[
          const SizedBox(height: AppSpacing.sm),
          _ResultMetric(
            icon: Icons.scale_rounded,
            label: l10n.weightedScore,
            value: '${result.weightedScore}/70',
            accent: accent,
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
        FilledButton(
          key: const Key('assessment-result-continue'),
          onPressed: () => context.go(
            pretest
                ? AppRoutes.theory(module.metadata.number)
                : AppRoutes.finalResult(module.metadata.number),
          ),
          child: Text(
            pretest ? l10n.continueToTheory : l10n.continueToMaterial,
          ),
        ),
      ],
    );
  }
}

class _ResultMetric extends StatelessWidget {
  const _ResultMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.card,
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        Icon(icon, color: accent, size: 24),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Final Result consumes the current in-memory attempt; fixtures remain useful
/// for isolated score-widget tests until persistence is added in Phase 8.
class FinalResultPage extends ConsumerWidget {
  const FinalResultPage({this.moduleId, this.calculation, super.key})
    : assert(moduleId != null || calculation != null);
  final String? moduleId;
  final FinalScoreCalculation? calculation;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current =
        calculation ??
        ref
            .watch(currentAttemptProvider(_moduleKey(moduleId!)))
            .finalCalculation;
    if (current == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context)!.finalScore),
        ),
        body: AppScrollablePage(
          children: [
            const SizedBox(height: AppSpacing.xl),
            Text(
              AppLocalizations.of(context)!.finalResultUnavailable,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              key: const Key('final-result-home'),
              onPressed: () => context.go(AppRoutes.home),
              child: Text(AppLocalizations.of(context)!.backToHome),
            ),
          ],
        ),
      );
    }
    final result = current;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.finalScore),
      ),
      body: AppScrollablePage(
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.heroStart, AppColors.heroEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppRadius.heroCard,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x240F172A),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white,
                  size: 44,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${result.finalScore}/100',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.finalScore,
                  style: const TextStyle(color: Color(0xFFE0EAFF)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: result.passed
                  ? AppColors.module3Tint
                  : AppColors.module2Tint,
              borderRadius: AppRadius.card,
            ),
            child: Row(
              children: [
                Icon(
                  result.passed
                      ? Icons.check_circle_rounded
                      : Icons.info_outline_rounded,
                  color: result.passed ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    result.passed ? l10n.tuntas : l10n.needsReview,
                    key: const Key('final-result-status'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _ResultMetric(
                  icon: Icons.assignment_outlined,
                  label: l10n.pretest,
                  value: '${result.preTestRaw}/100',
                  accent: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ResultMetric(
                  icon: Icons.fact_check_outlined,
                  label: l10n.posttest,
                  value: '${result.postTestRaw}/100',
                  accent: AppColors.module2,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _ResultMetric(
                  icon: Icons.scale_rounded,
                  label: l10n.weightedScore,
                  value: '${result.postTestWeighted}/70',
                  accent: AppColors.module3,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ResultMetric(
                  icon: Icons.extension_rounded,
                  label: l10n.practiceScore,
                  value: '${result.practice.totalScore}/30',
                  accent: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${l10n.learningGain}: ${result.learningGain >= 0 ? '+' : ''}${result.learningGain}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton(
            key: const Key('final-result-home'),
            onPressed: () => context.go(AppRoutes.home),
            child: Text(l10n.backToHome),
          ),
        ],
      ),
    );
  }
}

String _moduleKey(String moduleId) =>
    moduleId.startsWith('module_') ? moduleId : 'module_$moduleId';

PracticeScoreSummary practiceFixture() => PracticeScoreSummary([
  PracticeActivityScore(correctItems: 0, totalItems: 1),
  PracticeActivityScore(correctItems: 0, totalItems: 1),
  PracticeActivityScore(correctItems: 0, totalItems: 1),
]);
