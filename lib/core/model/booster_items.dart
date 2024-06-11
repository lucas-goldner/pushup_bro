import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

enum BoosterItems {
  doubleBoost,
  friendBoost;
}

extension BoosterItemsExtension on BoosterItems {
  String getLocalizedName(BuildContext context) => switch (this) {
        BoosterItems.doubleBoost => 'Double Boost',
        BoosterItems.friendBoost => 'Friend Boost',
      };

  AssetGenImage getIcon() => switch (this) {
        BoosterItems.doubleBoost => Assets.images.itemDouble,
        BoosterItems.friendBoost => Assets.images.itemConnect,
      };

  Color getBackgroundColor(BuildContext context) =>
      switch (this) {
        BoosterItems.doubleBoost => context.itemColorsTheme.doubleBoost,
        BoosterItems.friendBoost => context.itemColorsTheme.friendBoost,
      } ??
      Colors.transparent;
}
