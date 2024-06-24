import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pushup_bro/core/model/booster_items.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/features/island/widgets/quests/double_value_quest.dart';
import 'package:pushup_bro/features/island/widgets/quests/fast_pushups_quest.dart';
import 'package:pushup_bro/features/island/widgets/quests/long_pushups_quest.dart';
import 'package:pushup_bro/features/pushup_tracking/model/news.dart';

List<News> getNewsForDay(int day) => switch (day) {
      1 => [],
      2 => [
          News(
            title: 'Lucas gave you a boost!',
            description: 'description',
            type: NewsType.friendBoost,
            date: DateTime.now(),
          ),
        ],
      3 => [
          News(
            title: 'Double Bro Points Day!',
            description: 'Today you get double bro points for each pushup',
            type: NewsType.doublePoinstEvent,
            date: DateTime.now(),
          ),
        ],
      _ => [],
    };

List<BoosterItems> getItemsForDay(int day) => switch (day) {
      1 => [],
      2 => [
          BoosterItems.doublePoints,
        ],
      3 => [
          BoosterItems.friendBoost,
        ],
      _ => [],
    };

int getStreakForDay(int day) => switch (day) {
      1 => 1,
      2 => 2,
      3 => 3,
      _ => 1,
    };

const _lucasImage =
    'https://media.discordapp.net/attachments/1229873636845031554/1254926758495654069/5be.jpeg?ex=667b451e&is=6679f39e&hm=5cb86b48e7c515fca2dad149a25c33167a9718b57c62f71a3c8a2f44399c5531&=&format=webp';

List<Friend> openChallengesBrosAtDay(int day) => switch (day) {
      1 => [],
      2 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 31,
            sharedStreak: 1,
          ),
        ],
      3 => [],
      _ => [],
    };

List<Friend> brosForDay(int day) => switch (day) {
      1 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 30,
          ),
        ],
      2 => [],
      3 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 31,
            sharedStreak: 2,
          ),
        ],
      _ => [],
    };

List<User> getLeaderboardProfilesForDay(int day) => switch (day) {
      1 => [
          ...List.generate(
            30,
            (index) => User(
              name: 'User $index',
              image: '',
              streak: 0,
              longestStreak: 0,
              level: math.Random().nextInt(3),
              xp: 0,
              friends: [],
            ),
          ),
          User(
            name: 'Lucas',
            image: _lucasImage,
            streak: 30,
            longestStreak: 30,
            level: 5,
            xp: 0,
            friends: [],
          ),
        ],
      2 => [
          ...List.generate(
            30,
            (index) => User(
              name: 'User $index',
              image: '',
              streak: 0,
              longestStreak: 0,
              level: math.Random().nextInt(4),
              xp: 0,
              friends: [],
            ),
          ),
          User(
            name: 'Lucas',
            image: _lucasImage,
            streak: 30,
            longestStreak: 30,
            level: 5,
            xp: 0,
            friends: [],
          ),
        ],
      3 => [
          ...List.generate(
            30,
            (index) => User(
              name: 'User $index',
              image: '',
              streak: 0,
              longestStreak: 0,
              level: math.Random().nextInt(4),
              xp: 0,
              friends: [],
            ),
          ),
          User(
            name: 'Lucas',
            image: _lucasImage,
            streak: 30,
            longestStreak: 30,
            level: 6,
            xp: 0,
            friends: [],
          ),
        ],
      _ => [],
    };

Widget getJungleQuestOfDay(int day) => switch (day) {
      1 => const FastPushupsQuest(),
      2 => const DoubleValueQuest(),
      3 => const LongPushupsQuest(),
      _ => const DoubleValueQuest(),
    };

int getCommunityGoalOfDay(int day) => switch (day) {
      1 => 1000,
      2 => 3000,
      3 => 8000,
      _ => 1000,
    };
