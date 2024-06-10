import 'package:flutter/cupertino.dart';

enum NewsType {
  update(Color(0xFFE6E6E6)),
  friendBoost(Color(0xFFE6E6E6)),
  eventDay(Color(0xFFE6E6E6));

  const NewsType(this.color);

  final Color color;
}

class News {
  News({
    required this.title,
    required this.description,
    required this.type,
    required this.date,
  });

  final String title;
  final String description;
  final NewsType type;
  final DateTime date;
}
