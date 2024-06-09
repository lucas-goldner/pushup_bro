import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/progress/widgets/friend_profile.dart';
import 'package:pushup_bro/features/progress/widgets/leaderboard_profile.dart';
import 'package:pushup_bro/features/progress/widgets/profile.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});
  static const routeName = '/progress';

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  int selectedTab = 0;
  final List<Friend> friends = [
    Friend(
      name: 'Friend 1',
      image: 'https://picsum.photos/200',
      progress: (level: 0, points: 0),
    ),
    Friend(
      name: 'Friend 2',
      image: '',
      progress: (level: 2, points: 30),
    ),
    ...List.generate(
      8,
      (index) => Friend(
        name: 'Friend $index',
        image: 'https://picsum.photos/200',
        progress: (level: index, points: 10),
      ),
    ),
  ];

  final List<LeaderBoardUser> leaderBoardUsers = [
    ...List.generate(
      100,
      (index) => LeaderBoardUser(
        name: 'User $index',
        image: 'https://picsum.photos/200',
        progress: (level: 0, points: 0),
      ),
    ),
  ];

  void changeTab(int index) => setState(() => selectedTab = index);

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const Spacer(),
                  Flexible(
                    child: PBButton.icon(
                      context.l10n.shareProfile,
                      icon: CarbonIcons.share,
                      callback: () => {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Profile(name: 'Your name', imageUrl: ''),
              const SizedBox(height: 12),
              CupertinoSlidingSegmentedControl(
                thumbColor: context.colorScheme.inversePrimary,
                backgroundColor: context.colorScheme.primary,
                groupValue: selectedTab,
                children: {
                  0: Text(
                    context.l10n.friends,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  1: Text(
                    context.l10n.leaderboard,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                },
                onValueChanged: (val) => changeTab(val ?? 0),
              ),
              const SizedBox(height: 12),
              switch (selectedTab) {
                0 => Flexible(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: FriendProfile(friends[index]),
                      ),
                      itemCount: friends.length,
                    ),
                  ),
                1 => Flexible(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: LeaderboardProfile(leaderBoardUsers[index]),
                      ),
                      itemCount: leaderBoardUsers.length,
                    ),
                  ),
                _ => const SizedBox(),
              },
            ],
          ),
        ),
      );
}
