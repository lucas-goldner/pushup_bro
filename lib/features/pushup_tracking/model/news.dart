import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

enum NewsType {
  update,
  friendBoost,
  eventDay;
}

extension NewsTypeExtension on NewsType {
  Color getColor(BuildContext context) =>
      switch (this) {
        NewsType.update => context.colorScheme.primary,
        NewsType.friendBoost => context.itemColorsTheme.friendBoost,
        NewsType.eventDay => context.itemColorsTheme.doubleBoost,
      } ??
      Colors.transparent;
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
  Color getColor(BuildContext context) => type.getColor(context);
}
