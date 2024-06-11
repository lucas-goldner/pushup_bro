import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/minimized_user.dart';

@embedded
class Friend {
  Friend({
    required this.id,
    required this.name,
    required this.image,
    required this.streak,
    required this.longestStreak,
    required this.sharedStreak,
    required this.longestSharedStreak,
  });

  final Id id;
  final String name;
  final String image;
  final int streak;
  final int longestStreak;
  final int sharedStreak;
  final int longestSharedStreak;

  bool get hasSharedStreakGoing => sharedStreak > 0;

  MinimizedUser toMinimizedUser() => MinimizedUser(image: image, name: name);
}
