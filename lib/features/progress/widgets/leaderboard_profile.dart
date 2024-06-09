import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/features/progress/widgets/profile_image_box.dart';

class LeaderboardProfile extends StatelessWidget {
  const LeaderboardProfile(this.leaderBoardUser, {super.key});
  final LeaderBoardUser leaderBoardUser;

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
                      leaderBoardUser.image,
                      size: const Size(48, 48),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    leaderBoardUser.name,
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
