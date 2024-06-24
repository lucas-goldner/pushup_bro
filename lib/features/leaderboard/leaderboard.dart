import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/day_cubit.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';
import 'package:pushup_bro/core/extensions/list_ext.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/core/provider/data_for_day.dart';
import 'package:pushup_bro/features/leaderboard/widgets/leaderboard_profile.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});
  static const routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    final user = context.read<DBCubit>().state.user;

    final leaderBoardUsers = <User>[
      ...getLeaderboardProfilesForDay(context.read<DayCubit>().state.day),
      user,
    ]..sort(
        (a, b) => b.level.compareTo(a.level),
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
            const SearchBar(
              hintText: 'Search',
            ),
            Flexible(
              child: ListView(
                children: [
                  ...leaderBoardUsers.mapIndexed(
                    (index, user) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: LeaderboardProfile(
                            user: user,
                            ranking: index + 1,
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
