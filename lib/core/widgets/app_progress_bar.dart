import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    required this.value,
    super.key,
    this.color = AppColors.primary,
    this.height = 6,
  });

  final int value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final normalized = value.clamp(0, 100).toDouble() / 100;
    return Semantics(
      label: AppLocalizations.of(context)!.progressValue(value),
      value: '$value%',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height),
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: AppColors.border),
              FractionallySizedBox(
                widthFactor: normalized,
                alignment: Alignment.centerLeft,
                child: ColoredBox(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
