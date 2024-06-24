import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

enum GameMenuType {
  shop,
  quest,
  accessories,
  monkey;

  const GameMenuType();

  String getLocalizedTitle(BuildContext context) => switch (this) {
        GameMenuType.shop => context.l10n.shop,
        GameMenuType.quest => context.l10n.quest,
        GameMenuType.accessories => context.l10n.accessories,
        GameMenuType.monkey => context.l10n.monkey,
      };
}
