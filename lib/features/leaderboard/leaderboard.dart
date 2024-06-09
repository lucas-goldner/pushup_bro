import 'package:flutter/material.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/features/leaderboard/widgets/leaderboard_profile.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});
  static const routeName = '/leaderboard';

  final List<User> leaderBoardUsers = [
    ...List.generate(
      100,
      (index) => User(
        name: 'User $index',
        image: '',
        streak: 0,
        longestStreak: 0,
        level: 0,
        xp: 0,
        friends: [],
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
                    ...leaderBoardUsers.map(
                      (user) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: LeaderboardProfile(user),
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
