import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/features/friends/widgets/friend_profile.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  static const routeName = '/friends';

  final List<Friend> friends = [
    Friend(
      name: 'Friend 1',
      image: 'https://picsum.photos/200',
      streak: 12,
      longestStreak: 0,
      sharedStreak: 1,
      longestSharedStreak: 0,
    ),
    Friend(
      name: 'Friend 2',
      image: 'https://picsum.photos/200',
      streak: 3,
      longestStreak: 0,
      sharedStreak: 20,
      longestSharedStreak: 0,
    ),
    ...List.generate(
      8,
      (index) => Friend(
        name: 'Friend $index',
        image: '',
        streak: 0,
        longestStreak: 0,
        sharedStreak: 0,
        longestSharedStreak: 0,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
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
                      context.l10n.openChallenges(2),
                      style: context.textTheme.titleLarge,
                    ),
                    ...friends.take(2).map(
                          (friend) => Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                    ...friends.skip(2).map(
                          (friend) => Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: FriendProfile(friend),
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
