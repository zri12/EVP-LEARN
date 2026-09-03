import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../domain/models/assessment_result.dart';
import '../../../domain/models/module_content.dart';
import '../../../domain/scoring/practice_scoring.dart';
import '../../learning/providers/learning_providers.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/assessment_session_provider.dart';

class AssessmentPage extends ConsumerWidget {
  const AssessmentPage({required this.moduleId, required this.type, super.key});
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
          data: (module) => module == null
              ? const Scaffold(body: Center(child: Text('Content unavailable')))
              : _AssessmentBody(module: module, type: type),
        );
  }
}

class _AssessmentBody extends ConsumerWidget {
  const _AssessmentBody({required this.module, required this.type});
  final LearningModuleContent module;
  final AssessmentType type;

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
                        onPressed: state.isSubmitting || state.isComplete
                            ? null
                            : () => _submit(context, controller, state, type),
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
        ],
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
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
              body: AppPage(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    Icon(
                      type == AssessmentType.pretest
                          ? Icons.insights_rounded
                          : Icons.assessment_rounded,
                      size: 60,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      type == AssessmentType.pretest
                          ? l10n.diagnosticNote
                          : l10n.posttestResult,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          children: [
                            Text(
                              '${l10n.score}: ${result.rawScore}/100',
                              key: const Key('assessment-result-score'),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              '${l10n.correctAnswers}: ${result.correct}   ${l10n.incorrectAnswers}: ${result.incorrect}',
                            ),
                            if (result.weightedScore != null) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                '${l10n.weightedScore}: ${result.weightedScore}/70',
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    FilledButton(
                      key: const Key('assessment-result-continue'),
                      onPressed: () => context.go(
                        type == AssessmentType.pretest
                            ? AppRoutes.theory(
                                int.parse(module.metadata.number.toString()),
                              )
                            : AppRoutes.practice(module.metadata.number),
                      ),
                      child: Text(
                        type == AssessmentType.pretest
                            ? l10n.continueToTheory
                            : l10n.continueToMaterial,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}

/// Fixture-capable final result widget; persistence and normal production entry are deferred.
class FinalResultPage extends StatelessWidget {
  const FinalResultPage({required this.calculation, super.key});
  final FinalScoreCalculation calculation;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.finalScore)),
      body: AppPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${l10n.finalScore}: ${calculation.finalScore}/100',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '${l10n.posttestResult}: ${calculation.postTestWeighted}/70 + ${l10n.practiceScore}: ${calculation.practice.totalScore}/30',
            ),
            Text('${l10n.learningGain}: ${calculation.learningGain}'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              calculation.passed ? l10n.tuntas : l10n.needsReview,
              key: const Key('final-result-status'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

PracticeScoreSummary practiceFixture() => PracticeScoreSummary([
  PracticeActivityScore(correctItems: 0, totalItems: 1),
  PracticeActivityScore(correctItems: 0, totalItems: 1),
  PracticeActivityScore(correctItems: 0, totalItems: 1),
]);
