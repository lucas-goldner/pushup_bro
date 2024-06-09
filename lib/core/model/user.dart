import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/model/minimized_user.dart';

@collection
class User {
  User({
    required this.level,
    required this.xp,
    required this.friends,
    required this.name,
    required this.image,
    required this.streak,
    required this.longestStreak,
  });

  final Id id = 1;
  final int level;
  final int xp;
  final String name;
  final String image;
  final int streak;
  final List<Friend> friends;
  final int longestStreak;

  MinimizedUser toMinimizedUser() => MinimizedUser(
        name: name,
        image: image,
      );
}
