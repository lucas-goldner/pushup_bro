import 'package:flutter/cupertino.dart';
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

  Color getBackgroundColor() => switch (this) {
        BoosterItems.doubleBoost => const Color(0xFFfffcfc),
        BoosterItems.friendBoost => const Color(0xFFffecc4),
      };
}
