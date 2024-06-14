import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/model/minimized_user.dart';

part 'user.g.dart';

const Id _userId = 1;

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
    this.id = _userId,
  });

  factory User.emptyUser() => User(
        level: 1,
        xp: 0,
        name: '',
        image: '',
        streak: 0,
        friends: [],
        longestStreak: 0,
      );

  Id id;
  final int level;
  final int xp;
  final String name;
  final String image;
  final int streak;
  final List<Friend> friends;
  final int longestStreak;
  static Id get userId => _userId;

  User copyWith({
    int? level,
    int? xp,
    String? name,
    String? image,
    int? streak,
    List<Friend>? friends,
    int? longestStreak,
  }) =>
      User(
        level: level ?? this.level,
        xp: xp ?? this.xp,
        name: name ?? this.name,
        image: image ?? this.image,
        streak: streak ?? this.streak,
        friends: friends ?? this.friends,
        longestStreak: longestStreak ?? this.longestStreak,
      );

  MinimizedUser toMinimizedUser() => MinimizedUser(
        name: name,
        image: image,
      );
}
