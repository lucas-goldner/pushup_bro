import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

enum QuestType {
  intro(dismissable: false),
  dailyLogin(dismissable: false),
  jungleQuest(dismissable: true),
  community(dismissable: true),
  doubleValue(dismissable: false, canAppearAsJungleQuest: true),
  fastPushups(dismissable: false, canAppearAsJungleQuest: true),
  longPushups(dismissable: false, canAppearAsJungleQuest: true);

  const QuestType({
    required this.dismissable,
    this.canAppearAsJungleQuest = false,
  });

  final bool dismissable;
  final bool canAppearAsJungleQuest;

  String getLocalizedTitle(BuildContext context) => switch (this) {
        intro => context.l10n.introQuest,
        community => context.l10n.communityQuestTitle,
        dailyLogin => context.l10n.dailyLogin,
        jungleQuest => context.l10n.jungleQuest,
        _ => 'Nothing burger',
      };

  List<QuestType> get jungleQuests => QuestType.values
      .where((questType) => questType.canAppearAsJungleQuest)
      .toList();
}
