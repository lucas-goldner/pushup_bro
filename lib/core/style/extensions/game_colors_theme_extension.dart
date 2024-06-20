import 'package:flutter/material.dart';

class GameColorsThemeExtension
    extends ThemeExtension<GameColorsThemeExtension> {
  const GameColorsThemeExtension({
    required this.sand,
  });

  factory GameColorsThemeExtension.build() {
    return const GameColorsThemeExtension(
      sand: Color(0xFFe1cfae),
    );
  }

  final Color sand;

  @override
  ThemeExtension<GameColorsThemeExtension> copyWith({Color? sand}) {
    return GameColorsThemeExtension(
      sand: sand ?? this.sand,
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
    );
  }
}
