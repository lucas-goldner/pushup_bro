import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/core/widgets/profile_image_box.dart';
import 'package:pushup_bro/core/widgets/streak_star.dart';

class FriendProfile extends StatelessWidget {
  const FriendProfile(this.friend, {super.key});
  final Friend friend;

  Widget _buildMinimizedProfile(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ProfileImageBox(
                    friend.image,
                    size: const Size(48, 48),
                    iconSize: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  friend.name,
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.onSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildFullFriendProfile(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSecondary,
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
                        color: context.colorScheme.onSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        StreakStar(friend.streak),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.sharedStreak,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSecondary,
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
            friend.hasStreak
                ? context.l10n.acceptChallenge
                : context.l10n.sendChallenge,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => friend.hasStreak
      ? _buildFullFriendProfile(context)
      : _buildMinimizedProfile(context);
}
