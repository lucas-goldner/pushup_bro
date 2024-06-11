import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

enum BoosterItems {
  doublePoints,
  friendBoost;
}

extension BoosterItemsExtension on BoosterItems {
  String getLocalizedName(BuildContext context) => switch (this) {
        BoosterItems.doublePoints => context.l10n.doublePoints,
        BoosterItems.friendBoost => context.l10n.friendBoost,
      };

  AssetGenImage getIcon() => switch (this) {
        BoosterItems.doublePoints => Assets.images.itemDouble,
        BoosterItems.friendBoost => Assets.images.itemConnect,
      };

  Color getBackgroundColor(BuildContext context) =>
      switch (this) {
        BoosterItems.doublePoints => context.itemColorsTheme.doubleBoost,
        BoosterItems.friendBoost => context.itemColorsTheme.friendBoost,
      } ??
      Colors.transparent;
}
