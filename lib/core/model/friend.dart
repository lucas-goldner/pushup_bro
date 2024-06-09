import 'package:isar/isar.dart';

@embedded
class Friend {
  Friend({
    required this.name,
    required this.image,
    required this.streak,
    required this.longestStreak,
  });

  final String name;
  final String image;
  final int streak;
  final int longestStreak;

  bool get hasStreak => streak > 0;
}

typedef LeaderBoardUser = Friend;
