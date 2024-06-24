import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/widgets/minimized_profile.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/core/widgets/profile_image_box.dart';
import 'package:pushup_bro/core/widgets/streak_star.dart';
import 'package:pushup_bro/features/menu/model/routes.dart';

class FriendProfile extends StatefulWidget {
  const FriendProfile(
    this.friend, {
    this.friendIsInChallenge = false,
    super.key,
  });

  final Friend friend;
  final bool friendIsInChallenge;

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  bool _hasSent = false;

  @override
  Widget build(BuildContext context) => Visibility(
        visible:
            !widget.friendIsInChallenge && widget.friend.hasSharedStreakGoing,
        replacement: MinimizedProfile(
          widget.friend.toMinimizedUser(),
          leadingItem: Row(
            children: [
              if (widget.friend.hasSharedStreakGoing) ...[
                StreakStar(widget.friend.sharedStreak),
                const SizedBox(width: 8),
              ],
              SizedBox(
                width: 80,
                child: PBButton.icon(
                  icon: _hasSent
                      ? CarbonIcons.checkmark_filled
                      : CarbonIcons.send,
                  '',
                  callback: () => {setState(() => _hasSent = true)},
                ),
              ),
            ],
          ),
        ),
        child: Column(
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
                      widget.friend.image,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friend.name,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: context.colorScheme.onSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          StreakStar(widget.friend.sharedStreak),
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
              context.l10n.acceptChallenge,
              callback: () => {
                Navigator.of(context).pushReplacement(
                  navigateToPushupTracking(context),
                ),
              },
            ),
          ],
        ),
      );
}
