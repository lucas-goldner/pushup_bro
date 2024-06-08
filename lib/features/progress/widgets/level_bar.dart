import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/progress/model/level_scalings.dart';

class LevelBar extends StatelessWidget {
  LevelBar({
    required this.level,
    required this.experience,
    super.key,
  }) : _barWidth = LevelScaler().getCurrentExperienceRelativeToLevel(
          level,
          experience,
        );

  final int level;
  final int experience;
  final double _barWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: _barWidth,
          backgroundColor: context.colorScheme.secondary,
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              context.l10n.level(level),
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '$experience / ${LevelScaler().getLevelScaling(level)} XP',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
