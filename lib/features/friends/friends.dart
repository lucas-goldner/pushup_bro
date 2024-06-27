import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/day_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/provider/data_for_day.dart';
import 'package:pushup_bro/features/friends/widgets/friend_profile.dart';

class Friends extends StatelessWidget {
  const Friends({super.key});
  static const routeName = '/friends';

  @override
  Widget build(BuildContext context) {
    final openFriendsWithChallenges = openChallengesBrosAtDay(
      context.read<DayCubit>().state.day,
    );
    final friends = brosForDay(
      context.read<DayCubit>().state.day,
    );

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(height: 64),
            Flexible(
              child: ListView(
                children: [
                  Text(
                    context.l10n.openChallenges(
                      openFriendsWithChallenges.length,
                    ),
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.brosExplanation,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.theme.colorScheme.tertiary,
                    ),
                  ),
                  ...openFriendsWithChallenges.map(
                    (friend) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: FriendProfile(friend),
                        ),
                        const Divider(
                          indent: 60,
                          endIndent: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    context.l10n.friends,
                    style: context.textTheme.titleLarge,
                  ),
                  ...friends.map(
                    (friend) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: FriendProfile(
                            friend,
                            friendIsInChallenge: true,
                          ),
                        ),
                        const Divider(
                          indent: 60,
                          endIndent: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
