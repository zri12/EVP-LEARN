import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  // TODO(assets): Switch to bundled Inter once approved font files are migrated.
  static const systemFontFamily = 'Roboto';

  static TextTheme get textTheme => const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppColors.navy,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.navy,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.navy,
    ),
    bodyMedium: TextStyle(fontSize: 15, height: 1.6, color: AppColors.navy),
    bodySmall: TextStyle(
      fontSize: 13,
      height: 1.5,
      color: AppColors.secondaryText,
    ),
  );
}
