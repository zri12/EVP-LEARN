import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_page.dart';
import '../../../l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fields = [
      (l10n.fullName, 'AFRIDA DWI RAHMAWATI'),
      (l10n.studentId, '805230006'),
      (l10n.studyProgram, 'Tadris Bahasa Inggris'),
      (l10n.faculty, 'Pascasarjana'),
      (
        l10n.university,
        'Universitas Islam Negeri Sulthan Thaha Saifuddin Jambi',
      ),
      (l10n.supervisors, '1. Prof. Dr. Martinis, M.Pd\n2. Tartila, M.Pd, Ed.D'),
      (
        l10n.researchTitle,
        'The development of Android-based Teaching Materials in English Language Learning for Vocational High Schools',
      ),
      (l10n.year, '2026'),
    ];
    return AppScrollablePage(
      children: [
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              border: Border.all(color: const Color(0xFF93C5FD), width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 46,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.profileTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.profileSubtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.xl),
        Container(
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: AppRadius.card,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var index = 0; index < fields.length; index++) ...[
                _ProfileField(label: fields[index].$1, value: fields[index].$2),
                if (index != fields.length - 1)
                  const Divider(height: 1, color: AppColors.border),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 102,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 14,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
