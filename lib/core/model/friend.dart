import 'package:isar/isar.dart';

@embedded
class Friend {
  Friend({
    required this.name,
    required this.image,
    required this.progress,
  });

  final String name;
  final String image;
  final ({int level, int points}) progress;
}
