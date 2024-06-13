import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/minimized_user.dart';

part 'friend.g.dart';

@embedded
class Friend {
  Friend({
    this.id = '',
    this.name = '',
    this.image = '',
    this.streak = 0,
    this.longestStreak = 0,
    this.sharedStreak = 0,
    this.longestSharedStreak = 0,
  });

  final String id;
  final String name;
  final String image;
  final int streak;
  final int longestStreak;
  final int sharedStreak;
  final int longestSharedStreak;
  bool get hasSharedStreakGoing => sharedStreak > 0;

  MinimizedUser toMinimizedUser() => MinimizedUser(image: image, name: name);
}
