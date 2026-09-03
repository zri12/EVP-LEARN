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
        _TheoryHeroImage(module: module),
        const SizedBox(height: AppSpacing.lg),
        _TheoryIllustrationCard(
          key: Key('module${module.metadata.number}-theory-illustration-1'),
          module: module,
          caption: _illustrationCaptions(context, module.metadata.number)[0],
          painter: _illustrationPainters(module.metadata.number)[0],
        ),
        const SizedBox(height: AppSpacing.lg),
        _TheoryList(
          title: AppLocalizations.of(context)!.genericStructure,
          items: module.theory.genericStructure,
          color: moduleVisualFor(module.metadata.number).accent,
        ),
        const SizedBox(height: AppSpacing.lg),
        _TheoryIllustrationCard(
          key: Key('module${module.metadata.number}-theory-illustration-2'),
          module: module,
          caption: _illustrationCaptions(context, module.metadata.number)[1],
          painter: _illustrationPainters(module.metadata.number)[1],
        ),
        const SizedBox(height: AppSpacing.lg),
        _TheoryList(
          title: AppLocalizations.of(context)!.languageFeatures,
          items: module.theory.languageFeatures,
          color: moduleVisualFor(module.metadata.number).accent,
        ),
        const SizedBox(height: AppSpacing.xl),
        _TheoryIllustrationCard(
          key: Key('module${module.metadata.number}-theory-illustration-3'),
          module: module,
          caption: _illustrationCaptions(context, module.metadata.number)[2],
          painter: _illustrationPainters(module.metadata.number)[2],
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
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.modules);
              }
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

List<String> _illustrationCaptions(BuildContext context, int moduleNumber) {
  final l10n = AppLocalizations.of(context)!;
  return switch (moduleNumber) {
    1 => [
      l10n.theoryVisualFounder,
      l10n.theoryVisualFurniture,
      l10n.theoryVisualAssembly,
    ],
    2 => [
      l10n.theoryVisualPos,
      l10n.theoryVisualShelves,
      l10n.theoryVisualJacket,
    ],
    _ => [
      l10n.theoryVisualScan,
      l10n.theoryVisualPayment,
      l10n.theoryVisualReceipt,
    ],
  };
}

List<CustomPainter> _illustrationPainters(int moduleNumber) {
  final visual = moduleVisualFor(moduleNumber);
  return switch (moduleNumber) {
    1 => [
      _FounderStoryPainter(visual.accent, visual.tint),
      _FurnitureJourneyPainter(visual.accent, visual.tint),
      _FlatPackPainter(visual.accent, visual.tint),
    ],
    2 => [
      _PosTerminalPainter(visual.accent, visual.tint),
      _GondolaPainter(visual.accent, visual.tint),
      _LeatherJacketPainter(visual.accent, visual.tint),
    ],
    _ => [
      _ScanCheckoutPainter(visual.accent, visual.tint),
      _PaymentPainter(visual.accent, visual.tint),
      _ReceiptPainter(visual.accent, visual.tint),
    ],
  };
}

class _TheoryIllustrationCard extends StatelessWidget {
  const _TheoryIllustrationCard({
    required this.module,
    required this.caption,
    required this.painter,
    super.key,
  });
  final LearningModuleContent module;
  final String caption;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    final visual = moduleVisualFor(module.metadata.number);
    return Semantics(
      container: true,
      label: caption,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 156,
              width: double.infinity,
              decoration: BoxDecoration(
                color: visual.tint,
                borderRadius: AppRadius.small,
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomPaint(painter: painter),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              caption,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

class _TheoryHeroImage extends StatelessWidget {
  const _TheoryHeroImage({required this.module});
  final LearningModuleContent module;

  @override
  Widget build(BuildContext context) {
    final visual = moduleVisualFor(module.metadata.number);
    return Semantics(
      container: true,
      label: module.metadata.title,
      child: ClipRRect(
        borderRadius: AppRadius.card,
        child: SizedBox(
          key: Key('module${module.metadata.number}-theory-hero'),
          height: 154,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppAssets.moduleArt[module.metadata.id]!,
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      visual.accent.withValues(alpha: .82),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    module.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class _TheoryPainter extends CustomPainter {
  _TheoryPainter(this.accent, this.tint);
  final Color accent;
  final Color tint;

  Paint paintFor(
    Color color, {
    double width = 1,
    PaintingStyle style = PaintingStyle.fill,
  }) => Paint()
    ..color = color
    ..strokeWidth = width
    ..style = style
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  void rounded(Canvas canvas, Rect rect, Color color, {double radius = 12}) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      paintFor(color),
    );
  }

  @override
  bool shouldRepaint(covariant _TheoryPainter oldDelegate) => false;
}

class _FounderStoryPainter extends _TheoryPainter {
  _FounderStoryPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    rounded(
      canvas,
      Rect.fromLTWH(w * .06, h * .18, w * .88, h * .66),
      Colors.white,
    );
    final line = paintFor(
      accent.withValues(alpha: .28),
      width: 4,
      style: PaintingStyle.stroke,
    );
    canvas.drawLine(Offset(w * .18, h * .61), Offset(w * .82, h * .61), line);
    for (final x in [.2, .5, .8]) {
      canvas.drawCircle(Offset(w * x, h * .61), 7, paintFor(accent));
    }
    canvas.drawCircle(Offset(w * .22, h * .36), 15, paintFor(accent));
    final person = Path()
      ..moveTo(w * .13, h * .55)
      ..quadraticBezierTo(w * .22, h * .42, w * .31, h * .55)
      ..close();
    canvas.drawPath(person, paintFor(accent.withValues(alpha: .8)));
    rounded(
      canvas,
      Rect.fromLTWH(w * .42, h * .3, w * .16, h * .16),
      accent.withValues(alpha: .16),
      radius: 8,
    );
    canvas.drawCircle(Offset(w * .5, h * .38), 11, paintFor(accent));
    final arrow = paintFor(accent, width: 3, style: PaintingStyle.stroke);
    canvas.drawLine(Offset(w * .58, h * .38), Offset(w * .72, h * .38), arrow);
    canvas.drawLine(Offset(w * .67, h * .33), Offset(w * .72, h * .38), arrow);
    canvas.drawLine(Offset(w * .67, h * .43), Offset(w * .72, h * .38), arrow);
    rounded(
      canvas,
      Rect.fromLTWH(w * .74, h * .28, w * .12, h * .2),
      accent.withValues(alpha: .2),
      radius: 7,
    );
    canvas.drawLine(
      Offset(w * .77, h * .34),
      Offset(w * .83, h * .34),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .77, h * .4),
      Offset(w * .83, h * .4),
      paintFor(accent, width: 3),
    );
  }
}

class _FurnitureJourneyPainter extends _TheoryPainter {
  _FurnitureJourneyPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    rounded(
      canvas,
      Rect.fromLTWH(w * .08, h * .22, w * .35, h * .46),
      Colors.white,
      radius: 10,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .13, h * .3, w * .25, h * .23),
      tint,
      radius: 6,
    );
    canvas.drawLine(
      Offset(w * .25, h * .3),
      Offset(w * .25, h * .53),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .13, h * .42),
      Offset(w * .38, h * .42),
      paintFor(accent, width: 3),
    );
    final truck = Path()
      ..moveTo(w * .5, h * .42)
      ..lineTo(w * .72, h * .42)
      ..lineTo(w * .79, h * .54)
      ..lineTo(w * .5, h * .54)
      ..close();
    canvas.drawPath(truck, paintFor(accent.withValues(alpha: .18)));
    canvas.drawRect(
      Rect.fromLTWH(w * .54, h * .34, w * .17, h * .2),
      paintFor(accent),
    );
    canvas.drawCircle(Offset(w * .57, h * .58), 8, paintFor(AppColors.navy));
    canvas.drawCircle(Offset(w * .74, h * .58), 8, paintFor(AppColors.navy));
    final arrow = paintFor(accent, width: 3, style: PaintingStyle.stroke);
    canvas.drawLine(Offset(w * .38, h * .75), Offset(w * .72, h * .75), arrow);
    canvas.drawLine(Offset(w * .65, h * .68), Offset(w * .72, h * .75), arrow);
    canvas.drawLine(Offset(w * .65, h * .82), Offset(w * .72, h * .75), arrow);
    rounded(
      canvas,
      Rect.fromLTWH(w * .78, h * .62, w * .12, h * .16),
      accent.withValues(alpha: .28),
      radius: 4,
    );
  }
}

class _FlatPackPainter extends _TheoryPainter {
  _FlatPackPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    rounded(
      canvas,
      Rect.fromLTWH(w * .08, h * .3, w * .22, h * .32),
      accent.withValues(alpha: .18),
      radius: 8,
    );
    canvas.drawLine(
      Offset(w * .08, h * .3),
      Offset(w * .19, h * .22),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .3, h * .3),
      Offset(w * .19, h * .22),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .19, h * .22),
      Offset(w * .19, h * .62),
      paintFor(accent, width: 3),
    );
    final arrow = paintFor(accent, width: 3, style: PaintingStyle.stroke);
    canvas.drawLine(Offset(w * .37, h * .46), Offset(w * .55, h * .46), arrow);
    canvas.drawLine(Offset(w * .49, h * .39), Offset(w * .55, h * .46), arrow);
    canvas.drawLine(Offset(w * .49, h * .53), Offset(w * .55, h * .46), arrow);
    final chair = paintFor(accent);
    canvas.drawRect(Rect.fromLTWH(w * .68, h * .28, w * .12, h * .2), chair);
    canvas.drawRect(Rect.fromLTWH(w * .68, h * .48, w * .2, h * .08), chair);
    canvas.drawLine(
      Offset(w * .71, h * .56),
      Offset(w * .67, h * .75),
      paintFor(accent, width: 6),
    );
    canvas.drawLine(
      Offset(w * .84, h * .56),
      Offset(w * .88, h * .75),
      paintFor(accent, width: 6),
    );
    canvas.drawLine(
      Offset(w * .7, h * .32),
      Offset(w * .78, h * .32),
      paintFor(Colors.white, width: 3),
    );
  }
}

class _PosTerminalPainter extends _TheoryPainter {
  _PosTerminalPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(w * .1, h * .62, w * .8, h * .12),
      paintFor(accent.withValues(alpha: .22)),
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .25, h * .16, w * .5, h * .42),
      Colors.white,
      radius: 10,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .31, h * .22, w * .38, h * .22),
      accent.withValues(alpha: .18),
      radius: 5,
    );
    canvas.drawLine(
      Offset(w * .36, h * .3),
      Offset(w * .64, h * .3),
      paintFor(accent, width: 4),
    );
    canvas.drawLine(
      Offset(w * .36, h * .36),
      Offset(w * .56, h * .36),
      paintFor(accent, width: 4),
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .4, h * .58, w * .2, h * .14),
      accent,
      radius: 7,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .72, h * .52, w * .13, h * .18),
      accent.withValues(alpha: .3),
      radius: 4,
    );
    canvas.drawCircle(Offset(w * .28, h * .72), 9, paintFor(AppColors.navy));
    canvas.drawCircle(Offset(w * .72, h * .72), 9, paintFor(AppColors.navy));
  }
}

class _GondolaPainter extends _TheoryPainter {
  _GondolaPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shelf = paintFor(accent, width: 7, style: PaintingStyle.stroke);
    canvas.drawLine(Offset(w * .16, h * .2), Offset(w * .16, h * .8), shelf);
    canvas.drawLine(Offset(w * .84, h * .2), Offset(w * .84, h * .8), shelf);
    for (final y in [.3, .46, .62, .78]) {
      canvas.drawLine(Offset(w * .13, h * y), Offset(w * .87, h * y), shelf);
    }
    for (final pair in [(.24, .24), (.4, .4), (.56, .56), (.72, .72)]) {
      rounded(
        canvas,
        Rect.fromLTWH(w * pair.$1, h * (pair.$2 - .09), w * .09, h * .08),
        accent.withValues(alpha: .25),
        radius: 3,
      );
      rounded(
        canvas,
        Rect.fromLTWH(
          w * (pair.$1 + .12),
          h * (pair.$2 - .09),
          w * .1,
          h * .08,
        ),
        accent.withValues(alpha: .42),
        radius: 3,
      );
    }
    canvas.drawLine(
      Offset(w * .08, h * .84),
      Offset(w * .92, h * .84),
      paintFor(AppColors.navy, width: 4),
    );
  }
}

class _LeatherJacketPainter extends _TheoryPainter {
  _LeatherJacketPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final jacket = Path()
      ..moveTo(w * .38, h * .2)
      ..lineTo(w * .62, h * .2)
      ..lineTo(w * .78, h * .4)
      ..lineTo(w * .68, h * .48)
      ..lineTo(w * .66, h * .78)
      ..lineTo(w * .34, h * .78)
      ..lineTo(w * .32, h * .48)
      ..lineTo(w * .22, h * .4)
      ..close();
    canvas.drawPath(jacket, paintFor(accent.withValues(alpha: .68)));
    final detail = paintFor(
      AppColors.navy,
      width: 4,
      style: PaintingStyle.stroke,
    );
    canvas.drawLine(Offset(w * .5, h * .25), Offset(w * .42, h * .46), detail);
    canvas.drawLine(Offset(w * .42, h * .46), Offset(w * .62, h * .72), detail);
    canvas.drawLine(Offset(w * .34, h * .63), Offset(w * .66, h * .63), detail);
    canvas.drawLine(Offset(w * .38, h * .25), Offset(w * .5, h * .36), detail);
    canvas.drawLine(Offset(w * .62, h * .25), Offset(w * .5, h * .36), detail);
    canvas.drawCircle(Offset(w * .55, h * .51), 5, paintFor(Colors.white));
    canvas.drawCircle(Offset(w * .61, h * .59), 5, paintFor(Colors.white));
    rounded(
      canvas,
      Rect.fromLTWH(w * .08, h * .66, w * .18, h * .1),
      accent.withValues(alpha: .2),
      radius: 4,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .74, h * .3, w * .16, h * .1),
      accent.withValues(alpha: .2),
      radius: 4,
    );
  }
}

class _ScanCheckoutPainter extends _TheoryPainter {
  _ScanCheckoutPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(w * .08, h * .68, w * .84, h * .12),
      paintFor(accent.withValues(alpha: .22)),
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .18, h * .25, w * .27, h * .32),
      Colors.white,
      radius: 8,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .23, h * .3, w * .17, h * .15),
      accent.withValues(alpha: .2),
      radius: 4,
    );
    final scanner = Path()
      ..moveTo(w * .57, h * .3)
      ..lineTo(w * .73, h * .3)
      ..lineTo(w * .69, h * .52)
      ..lineTo(w * .58, h * .52)
      ..close();
    canvas.drawPath(scanner, paintFor(accent));
    canvas.drawLine(
      Offset(w * .57, h * .52),
      Offset(w * .51, h * .68),
      paintFor(accent, width: 8),
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .76, h * .44, w * .12, h * .18),
      accent.withValues(alpha: .42),
      radius: 4,
    );
    for (var i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(w * (.78 + i * .025), h * .48),
        Offset(w * (.78 + i * .025), h * .58),
        paintFor(AppColors.navy, width: 2),
      );
    }
    final beam = paintFor(AppColors.teal.withValues(alpha: .8), width: 3);
    canvas.drawLine(Offset(w * .67, h * .53), Offset(w * .81, h * .53), beam);
  }
}

class _PaymentPainter extends _TheoryPainter {
  _PaymentPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    rounded(
      canvas,
      Rect.fromLTWH(w * .34, h * .18, w * .32, h * .4),
      Colors.white,
      radius: 9,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .4, h * .25, w * .2, h * .15),
      accent.withValues(alpha: .2),
      radius: 4,
    );
    canvas.drawLine(
      Offset(w * .43, h * .48),
      Offset(w * .57, h * .48),
      paintFor(accent, width: 4),
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .14, h * .58, w * .28, h * .12),
      accent.withValues(alpha: .35),
      radius: 5,
    );
    canvas.drawCircle(Offset(w * .2, h * .64), 5, paintFor(accent));
    canvas.drawCircle(Offset(w * .27, h * .64), 5, paintFor(accent));
    final hand = Path()
      ..moveTo(w * .7, h * .72)
      ..quadraticBezierTo(w * .75, h * .54, w * .82, h * .55)
      ..lineTo(w * .9, h * .67)
      ..lineTo(w * .83, h * .78)
      ..close();
    canvas.drawPath(hand, paintFor(accent.withValues(alpha: .6)));
    rounded(
      canvas,
      Rect.fromLTWH(w * .7, h * .42, w * .13, h * .08),
      accent,
      radius: 3,
    );
    canvas.drawLine(
      Offset(w * .73, h * .46),
      Offset(w * .8, h * .46),
      paintFor(Colors.white, width: 2),
    );
  }
}

class _ReceiptPainter extends _TheoryPainter {
  _ReceiptPainter(super.accent, super.tint);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    rounded(
      canvas,
      Rect.fromLTWH(w * .16, h * .55, w * .68, h * .18),
      accent.withValues(alpha: .2),
      radius: 6,
    );
    rounded(
      canvas,
      Rect.fromLTWH(w * .3, h * .3, w * .4, h * .4),
      Colors.white,
      radius: 5,
    );
    final paper = Path()
      ..moveTo(w * .3, h * .3)
      ..lineTo(w * .7, h * .3)
      ..lineTo(w * .7, h * .72)
      ..lineTo(w * .65, h * .67)
      ..lineTo(w * .6, h * .72)
      ..lineTo(w * .55, h * .67)
      ..lineTo(w * .5, h * .72)
      ..lineTo(w * .45, h * .67)
      ..lineTo(w * .4, h * .72)
      ..lineTo(w * .35, h * .67)
      ..lineTo(w * .3, h * .72)
      ..close();
    canvas.drawPath(paper, paintFor(Colors.white));
    for (final y in [.39, .47, .55]) {
      canvas.drawLine(
        Offset(w * .38, h * y),
        Offset(w * .62, h * y),
        paintFor(accent, width: 4),
      );
    }
    canvas.drawLine(
      Offset(w * .4, h * .62),
      Offset(w * .55, h * .62),
      paintFor(AppColors.teal, width: 4),
    );
    canvas.drawLine(
      Offset(w * .68, h * .38),
      Offset(w * .8, h * .28),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .74, h * .28),
      Offset(w * .8, h * .28),
      paintFor(accent, width: 3),
    );
    canvas.drawLine(
      Offset(w * .8, h * .28),
      Offset(w * .8, h * .34),
      paintFor(accent, width: 3),
    );
  }
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
