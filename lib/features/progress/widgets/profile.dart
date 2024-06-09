import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/progress/widgets/level_bar.dart';
import 'package:pushup_bro/features/progress/widgets/profile_image_box.dart';
import 'package:pushup_bro/features/progress/widgets/streak_star.dart';

class Profile extends StatelessWidget {
  const Profile({
    required this.name,
    required this.imageUrl,
    super.key,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.colorScheme.onSecondary,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ProfileImageBox(imageUrl),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          const StreakStar(2),
                          const SizedBox(width: 8),
                          Text(
                            context.l10n.dayStreak,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LevelBar(level: 2, experience: 30),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
}