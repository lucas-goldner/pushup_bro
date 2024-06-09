import 'package:isar/isar.dart';
import 'package:pushup_bro/core/model/friend.dart';

@collection
class User {
  User(
    this.level,
    this.xp,
    this.friends,
  );

  final Id id = 1;
  final int level;
  final int xp;
  final List<Friend> friends;
}
