import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/progress/model/level_scalings.dart';

const _barWidthMultiplier = 0.8;

class LevelBar extends StatelessWidget {
  LevelBar({
    required this.level,
    required this.experience,
    super.key,
  }) : _barWidth = LevelScaler().getBarWidth(level, experience);

  final int level;
  final int experience;
  final double _barWidth;

  double _getFullBarWidth(BuildContext context) => context.sizeOf.width * 0.82;

  @override
  Widget build(BuildContext context) {
    final fullWidth = _getFullBarWidth(context);

    return Stack(
      children: [
        Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: SizedBox(
                width: context.sizeOf.width,
                height: 20,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    context.l10n.level(level),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Text(
                      '$experience / ${LevelScaler().getExperienceForNextLevel(level)} XP',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: context.progressTheme.levelBarGradient,
            ),
            child: SizedBox(
              width: 1.0 >= _barWidth
                  ? (fullWidth * _barWidth)
                  : (fullWidth * _barWidthMultiplier),
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}


  // Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: LinearProgressIndicator(
  //               value: widget.pushupSet.pushups.length / 100,
  //               backgroundColor: context.colorScheme.surface,
  //               valueColor: AlwaysStoppedAnimation<Color>(
  //                 context.colorScheme.primary,
  //               ),
  //             ),
  //           ),