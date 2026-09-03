import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_page.dart';
import '../../../data/content/audio_asset_resolver.dart';
import '../../../domain/models/module_content.dart';
import '../../../l10n/app_localizations.dart';
import '../../learning/providers/learning_audio_controller.dart';
import '../../learning/providers/learning_providers.dart';
import '../../modules/presentation/widgets/module_card.dart';

class ModuleOverviewPage extends StatelessWidget {
  const ModuleOverviewPage({required this.moduleId, super.key});
  final String moduleId;

  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) {
      final visual = moduleVisualFor(module.metadata.number);
      return LearningPageScaffold(
        module: module,
        title: AppLocalizations.of(context)!.moduleOverview,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: visual.tint,
              borderRadius: AppRadius.heroCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MODULE ${module.metadata.number.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: visual.accent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  module.metadata.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  module.metadata.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Image.asset(
                  AppAssets.moduleArt[module.metadata.id]!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionCard(
            title: AppLocalizations.of(context)!.aboutThisModule,
            child: Text(module.metadata.overview),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionCard(
            title: AppLocalizations.of(context)!.learningJourney,
            child: const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Pre-test')),
                Chip(label: Text('Learn')),
                Chip(label: Text('Practice')),
                Chip(label: Text('Post-test')),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _PrimaryButton(
            label: AppLocalizations.of(context)!.startLearning,
            onPressed: () =>
                context.push(AppRoutes.objectives(module.metadata.number)),
          ),
        ],
      );
    },
  );
}

class LearningObjectivesPage extends StatelessWidget {
  const LearningObjectivesPage({required this.moduleId, super.key});
  final String moduleId;
  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) => LearningPageScaffold(
      module: module,
      title: AppLocalizations.of(context)!.learningObjectives,
      children: [
        Text(
          AppLocalizations.of(context)!.learningObjectivesIntro,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        ...module.objectives.indexed.expand(
          (entry) => [
            _NumberedCard(
              number: entry.$1 + 1,
              text: entry.$2.text,
              color: moduleVisualFor(module.metadata.number).accent,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _PrimaryButton(
          label: AppLocalizations.of(context)!.continueToPretest,
          onPressed: () =>
              context.push(AppRoutes.pretest(module.metadata.number)),
        ),
      ],
    ),
  );
}

class TheoryPage extends StatelessWidget {
  const TheoryPage({required this.moduleId, super.key});
  final String moduleId;
  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) => LearningPageScaffold(
      module: module,
      title: AppLocalizations.of(context)!.theory,
      children: [
        _SectionCard(
          title: AppLocalizations.of(context)!.definitionAndPurpose,
          child: Text(module.theory.definition),
        ),
        const SizedBox(height: AppSpacing.lg),
        _TheoryList(
          title: AppLocalizations.of(context)!.genericStructure,
          items: module.theory.genericStructure,
          color: moduleVisualFor(module.metadata.number).accent,
        ),
        const SizedBox(height: AppSpacing.lg),
        _TheoryList(
          title: AppLocalizations.of(context)!.languageFeatures,
          items: module.theory.languageFeatures,
          color: moduleVisualFor(module.metadata.number).accent,
        ),
        const SizedBox(height: AppSpacing.xl),
        _PrimaryButton(
          label: AppLocalizations.of(context)!.vocabularyPreview,
          onPressed: () =>
              context.push(AppRoutes.vocabulary(module.metadata.number)),
        ),
      ],
    ),
  );
}

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({required this.moduleId, super.key});
  final String moduleId;
  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) => LearningPageScaffold(
      module: module,
      title: AppLocalizations.of(context)!.vocabularyPreview,
      children: [
        ...module.vocabulary.expand(
          (word) => [
            _VocabularyCard(word: word),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _PrimaryButton(
          label: AppLocalizations.of(context)!.continueToReading,
          onPressed: () => context.push(
            AppRoutes.reading(module.metadata.number, module.readings.first.id),
          ),
        ),
      ],
    ),
  );
}

class ReadingPage extends StatelessWidget {
  const ReadingPage({
    required this.moduleId,
    required this.readingId,
    super.key,
  });
  final String moduleId;
  final String readingId;

  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) {
      final reading = module.readings.firstWhere(
        (item) => item.id == readingId,
        orElse: () => module.readings.first,
      );
      final index = module.readings.indexOf(reading);
      return LearningPageScaffold(
        module: module,
        title: AppLocalizations.of(context)!.reading,
        children: [
          if (module.readings.length > 1)
            _ReadingSelector(module: module, selected: reading),
          Text(reading.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(reading.subtitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          _ReadingAudioCard(
            assetPath: const AudioAssetResolver().resolveReading(
              reading.readingAudioKey,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...reading.sections.expand(
            (section) => [
              Text(
                section.heading,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: moduleVisualFor(module.metadata.number).accent,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              _GlossaryText(body: section.body, glossary: reading.glossary),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
          _PrimaryButton(
            label: index + 1 < module.readings.length
                ? AppLocalizations.of(context)!.nextReading
                : AppLocalizations.of(context)!.interactivePractice,
            onPressed: () => index + 1 < module.readings.length
                ? context.pushReplacement(
                    AppRoutes.reading(
                      module.metadata.number,
                      module.readings[index + 1].id,
                    ),
                  )
                : context.push(AppRoutes.practice(module.metadata.number)),
          ),
        ],
      );
    },
  );
}

enum LearningGatewayStage { pretest, practice, posttest, result }

class LearningGatewayPage extends StatelessWidget {
  const LearningGatewayPage({
    required this.moduleId,
    required this.stage,
    super.key,
  });
  final String moduleId;
  final LearningGatewayStage stage;
  @override
  Widget build(BuildContext context) => _ModulePage(
    moduleId: moduleId,
    builder: (context, module) => LearningPageScaffold(
      module: module,
      title: switch (stage) {
        LearningGatewayStage.pretest => 'Pre-test',
        LearningGatewayStage.practice => 'Interactive Practice',
        LearningGatewayStage.posttest => 'Post-test',
        LearningGatewayStage.result => 'Final Result',
      },
      children: [
        _SectionCard(
          title: stage == LearningGatewayStage.pretest
              ? 'Pre-test'
              : AppLocalizations.of(context)!.interactivePractice,
          child: Text(
            stage == LearningGatewayStage.pretest
                ? AppLocalizations.of(context)!.pretestGatewayDescription
                : AppLocalizations.of(context)!.nextLearningActivity,
          ),
        ),
        if (stage == LearningGatewayStage.pretest) ...[
          const SizedBox(height: AppSpacing.xl),
          _PrimaryButton(
            label: 'Back to Objectives',
            onPressed: () => context.pop(),
          ),
        ],
      ],
    ),
  );
}

class LearningPageScaffold extends ConsumerWidget {
  const LearningPageScaffold({
    required this.module,
    required this.title,
    required this.children,
    super.key,
  });
  final LearningModuleContent module;
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visual = moduleVisualFor(module.metadata.number);
    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          label: AppLocalizations.of(context)!.back,
          button: true,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              ref.read(learningAudioProvider.notifier).stop();
              context.pop();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.moduleLabel(module.metadata.number),
              style: const TextStyle(fontSize: 12),
            ),
            Text(title, style: const TextStyle(fontSize: 17)),
          ],
        ),
      ),
      body: AppScrollablePage(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: visual.accent,
              borderRadius: AppRadius.small,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

class _ModulePage extends ConsumerWidget {
  const _ModulePage({required this.moduleId, required this.builder});
  final String moduleId;
  final Widget Function(BuildContext context, LearningModuleContent module)
  builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(learningModuleProvider(moduleId))
      .when(
        data: (module) =>
            module == null ? const _ContentError() : builder(context, module),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => const _ContentError(),
      );
}

class _ContentError extends StatelessWidget {
  const _ContentError();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: TextButton(
        onPressed: () => context.go(AppRoutes.modules),
        child: Text(AppLocalizations.of(context)!.contentUnavailable),
      ),
    ),
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: AppRadius.card,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    ),
  );
}

class _NumberedCard extends StatelessWidget {
  const _NumberedCard({
    required this.number,
    required this.text,
    required this.color,
  });
  final int number;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) =>
      _SectionCard(title: '$number', child: Text(text));
}

class _TheoryList extends StatelessWidget {
  const _TheoryList({
    required this.title,
    required this.items,
    required this.color,
  });
  final String title;
  final List<TheorySection> items;
  final Color color;
  @override
  Widget build(BuildContext context) => _SectionCard(
    title: title,
    child: Column(
      children: items
          .map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_outline_rounded, color: color),
              title: Text(item.heading),
              subtitle: Text(item.detail),
            ),
          )
          .toList(),
    ),
  );
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 52,
    child: FilledButton(onPressed: onPressed, child: Text(label)),
  );
}

class _VocabularyCard extends StatelessWidget {
  const _VocabularyCard({required this.word});
  final VocabularyItem word;
  @override
  Widget build(BuildContext context) => _SectionCard(
    title: word.term,
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.partOfSpeech,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(word.meaning),
            ],
          ),
        ),
        _AudioButton(
          assetPath: const AudioAssetResolver().resolveVocabulary(
            word.audioKey,
          ),
          label: 'Play pronunciation for ${word.term}',
        ),
      ],
    ),
  );
}

class _AudioButton extends ConsumerWidget {
  const _AudioButton({required this.assetPath, required this.label});
  final String assetPath;
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audio = ref.watch(learningAudioProvider);
    final isPlaying =
        audio.assetPath == assetPath &&
        audio.status == LearningAudioStatus.playing;
    return Semantics(
      label: label,
      button: true,
      child: IconButton(
        icon: Icon(
          isPlaying
              ? Icons.pause_circle_filled_rounded
              : Icons.volume_up_rounded,
        ),
        color: AppColors.primary,
        iconSize: 32,
        onPressed: () =>
            ref.read(learningAudioProvider.notifier).toggle(assetPath),
      ),
    );
  }
}

class _ReadingAudioCard extends StatelessWidget {
  const _ReadingAudioCard({required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) => _SectionCard(
    title: AppLocalizations.of(context)!.listenToReading,
    child: Row(
      children: [
        Expanded(child: Text(AppLocalizations.of(context)!.localAudio)),
        _AudioButton(assetPath: assetPath, label: 'Play reading audio'),
      ],
    ),
  );
}

class _ReadingSelector extends StatelessWidget {
  const _ReadingSelector({required this.module, required this.selected});
  final LearningModuleContent module;
  final ReadingContent selected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    children: module.readings.indexed
        .map(
          (entry) => ChoiceChip(
            label: Text(
              '${AppLocalizations.of(context)!.reading} ${entry.$1 + 1}',
            ),
            selected: entry.$2.id == selected.id,
            onSelected: (_) => context.pushReplacement(
              AppRoutes.reading(module.metadata.number, entry.$2.id),
            ),
          ),
        )
        .toList(),
  );
}

class _GlossaryText extends StatelessWidget {
  const _GlossaryText({required this.body, required this.glossary});
  final String body;
  final List<GlossaryItem> glossary;
  @override
  Widget build(BuildContext context) {
    final terms = glossary.map((item) => RegExp.escape(item.term)).toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    final expression = RegExp(terms.join('|'), caseSensitive: false);
    final spans = <InlineSpan>[];
    var cursor = 0;
    for (final match in expression.allMatches(body)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: body.substring(cursor, match.start)));
      }
      final item = glossary.firstWhere(
        (word) => word.term.toLowerCase() == match.group(0)!.toLowerCase(),
      );
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: InkWell(
            key: Key('glossary-${item.id}'),
            onTap: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => _GlossarySheet(item: item),
            ),
            child: Text(
              match.group(0)!,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );
      cursor = match.end;
    }
    if (cursor < body.length) spans.add(TextSpan(text: body.substring(cursor)));
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text.rich(
        TextSpan(children: spans),
        style: const TextStyle(
          fontSize: 17,
          height: 1.65,
          color: AppColors.navy,
        ),
      ),
    );
  }
}

class _GlossarySheet extends StatelessWidget {
  const _GlossarySheet({required this.item});
  final GlossaryItem item;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: AppRadius.small,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: Text(
                item.term,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        Text(item.partOfSpeech, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpacing.md),
        _AudioButton(
          assetPath: const AudioAssetResolver().resolveGlossary(item.audioKey),
          label: 'Play pronunciation for ${item.term}',
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(item.meaning),
        const SizedBox(height: AppSpacing.lg),
      ],
    ),
  );
}
