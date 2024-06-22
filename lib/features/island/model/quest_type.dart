import 'package:flutter/material.dart';

enum QuestType {
  intro(dismissable: false),
  dailyLogin(dismissable: false),
  community(dismissable: true),
  fastPushups(dismissable: false),
  longPushups(dismissable: false);

  const QuestType({required this.dismissable});

  final bool dismissable;

  String getLocalizedTitle(BuildContext context) => switch (this) {
        intro => 'Intro Quest',
        community => 'Coming together',
        dailyLogin => 'Daily Login',
        _ => 'Nothingburger',
      };
}
