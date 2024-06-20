import 'package:flutter/material.dart';

class GameColorsThemeExtension
    extends ThemeExtension<GameColorsThemeExtension> {
  const GameColorsThemeExtension({
    required this.sand,
    required this.grass,
  });

  factory GameColorsThemeExtension.build() {
    return const GameColorsThemeExtension(
      sand: Color(0xFFe1cfae),
      grass: Color(0xFFabc090),
    );
  }

  final Color sand;
  final Color grass;

  @override
  ThemeExtension<GameColorsThemeExtension> copyWith({
    Color? sand,
    Color? grass,
  }) {
    return GameColorsThemeExtension(
      sand: sand ?? this.sand,
      grass: grass ?? this.grass,
    );
  }

  @override
  ThemeExtension<GameColorsThemeExtension> lerp(
    covariant ThemeExtension<GameColorsThemeExtension>? other,
    double t,
  ) {
    if (other is! GameColorsThemeExtension) {
      return this;
    }

    return GameColorsThemeExtension(
      sand: Color.lerp(sand, other.sand, t) ?? sand,
      grass: Color.lerp(grass, other.grass, t) ?? grass,
    );
  }
}
