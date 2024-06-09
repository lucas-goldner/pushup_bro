import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/progress/widgets/profile_image_box.dart';
import 'package:pushup_bro/features/progress/widgets/streak_star.dart';

class FriendProfile extends StatelessWidget {
  const FriendProfile(this.friend, {super.key});
  final Friend friend;

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
                    child: ProfileImageBox(
                      friend.image,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.name,
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
                            context.l10n.sharedStreak,
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
            PBButton(
              friend.image.isNotEmpty
                  ? context.l10n.sendChallenge
                  : context.l10n.acceptChallenge,
            ),
          ],
        ),
      );
}
