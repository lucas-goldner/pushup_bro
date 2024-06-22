import 'package:flutter/material.dart';

enum QuestType {
  intro,
  fastPushups,
  longPushups;

  const QuestType();

  String getLocalizedTitle(BuildContext context) => switch (this) {
        intro => 'Intro Quest',
        fastPushups => 'Fast pushups',
        longPushups => 'LongPushups',
      };
}
