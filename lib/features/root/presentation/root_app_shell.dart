import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/localization/locale_preferences.dart';
import '../../../l10n/app_localizations.dart';

class RootAppShell extends ConsumerWidget {
  const RootAppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final titles = [
      l10n.appName,
      l10n.navModules,
      l10n.navProgress,
      l10n.navProfile,
    ];
    final index = navigationShell.currentIndex;

    return Scaffold(
      body: Column(
        children: [
          _RootHeader(
            title: titles[index],
            showLanguage: index != 3,
            onLanguageTap: () => _openLanguageSheet(context, ref),
          ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: _RootBottomNavigation(
        currentIndex: index,
        onSelected: navigationShell.goBranch,
      ),
    );
  }

  Future<void> _openLanguageSheet(BuildContext context, WidgetRef ref) async {
    final selectedLocale = await showModalBottomSheet<Locale>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _LanguageSelectorSheet(),
    );
    if (selectedLocale != null && context.mounted) {
      await ref
          .read(localeControllerProvider.notifier)
          .setLocale(selectedLocale);
    }
  }
}

class _RootHeader extends StatelessWidget {
  const _RootHeader({
    required this.title,
    required this.showLanguage,
    required this.onLanguageTap,
  });

  final String title;
  final bool showLanguage;
  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      bottom: false,
      child: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: AppRadius.button,
                ),
                child: Image.asset(
                  'assets/images/branding/evp-icon.png',
                  semanticLabel: l10n.appName,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: showLanguage
                    ? Semantics(
                        button: true,
                        label: l10n.languageSelector,
                        child: IconButton(
                          onPressed: onLanguageTap,
                          icon: const Icon(Icons.language_rounded),
                          tooltip: l10n.languageTitle,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RootBottomNavigation extends StatelessWidget {
  const _RootBottomNavigation({
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final destinations = [
      (l10n.navHome, Icons.home_outlined, Icons.home_rounded),
      (l10n.navModules, Icons.layers_outlined, Icons.layers_rounded),
      (l10n.navProgress, Icons.bar_chart_outlined, Icons.bar_chart_rounded),
      (l10n.navProfile, Icons.person_outline_rounded, Icons.person_rounded),
    ];

    return Material(
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Container(
          height: 72,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: List.generate(destinations.length, (index) {
              final destination = destinations[index];
              final selected = currentIndex == index;
              return Expanded(
                child: Semantics(
                  button: true,
                  selected: selected,
                  label: destination.$1,
                  child: InkWell(
                    key: Key('root-nav-$index'),
                    onTap: () => onSelected(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selected ? destination.$3 : destination.$2,
                          color: selected
                              ? AppColors.primary
                              : AppColors.mutedText,
                          size: selected ? 23 : 21,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          destination.$1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected
                                ? AppColors.primary
                                : AppColors.mutedText,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectorSheet extends ConsumerStatefulWidget {
  const _LanguageSelectorSheet();

  @override
  ConsumerState<_LanguageSelectorSheet> createState() =>
      _LanguageSelectorSheetState();
}

class _LanguageSelectorSheetState
    extends ConsumerState<_LanguageSelectorSheet> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = ref.read(localeControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.languageTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _LocaleOption(
              label: l10n.languageIndonesian,
              selected: _selectedLocale.languageCode == 'id',
              onTap: () => setState(() => _selectedLocale = const Locale('id')),
            ),
            const SizedBox(height: AppSpacing.sm),
            _LocaleOption(
              label: l10n.languageEnglish,
              selected: _selectedLocale.languageCode == 'en',
              onTap: () => setState(() => _selectedLocale = const Locale('en')),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_selectedLocale),
                child: Text(l10n.apply),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocaleOption extends StatelessWidget {
  const _LocaleOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      inMutuallyExclusiveGroup: true,
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.small,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? AppColors.softBlue : AppColors.surface,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
            borderRadius: AppRadius.small,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? AppColors.primaryDark : AppColors.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: selected ? AppColors.primary : const Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
