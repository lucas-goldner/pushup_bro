import 'package:flutter/material.dart';

enum QuestType {
  intro,
  community,
  fastPushups,
  longPushups;

  const QuestType();

  String getLocalizedTitle(BuildContext context) => switch (this) {
        intro => 'Intro Quest',
        community => 'Coming together',
        _ => 'Nothingburger',
      };
}
