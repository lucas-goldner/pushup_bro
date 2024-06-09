import 'package:flutter/material.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/features/leaderboard/widgets/leaderboard_profile.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});
  static const routeName = '/leaderboard';

  final List<LeaderBoardUser> leaderBoardUsers = [
    ...List.generate(
      100,
      (index) => LeaderBoardUser(
        name: 'User $index',
        image: 'https://picsum.photos/200',
        streak: 0,
        longestStreak: 0,
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
              Flexible(
                child: Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: LeaderboardProfile(leaderBoardUsers[index]),
                    ),
                    itemCount: leaderBoardUsers.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
