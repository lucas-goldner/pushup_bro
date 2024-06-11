import 'package:flutter/material.dart';

class ItemColorsThemeExtensions
    extends ThemeExtension<ItemColorsThemeExtensions> {
  const ItemColorsThemeExtensions({
    this.doubleBoost,
    this.friendBoost,
  });

  final Color? doubleBoost;
  final Color? friendBoost;

  @override
  ThemeExtension<ItemColorsThemeExtensions> copyWith() =>
      ItemColorsThemeExtensions(
        doubleBoost: doubleBoost,
        friendBoost: friendBoost,
      );

  @override
  ThemeExtension<ItemColorsThemeExtensions> lerp(
    covariant ThemeExtension<ItemColorsThemeExtensions>? other,
    double t,
  ) {
    if (other is! ItemColorsThemeExtensions) {
      return this;
    }

    return ItemColorsThemeExtensions(
      doubleBoost: Color.lerp(doubleBoost, other.doubleBoost, t),
      friendBoost: Color.lerp(friendBoost, other.friendBoost, t),
    );
  }
}
