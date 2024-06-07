import 'package:flutter/material.dart';

class ProgressThemeExtension extends ThemeExtension<ProgressThemeExtension> {
  ProgressThemeExtension({
    required this.levelBarGradient,
    required this.streakStarGradient,
  });

  final Gradient? levelBarGradient;
  final Gradient? streakStarGradient;

  @override
  ThemeExtension<ProgressThemeExtension> copyWith({
    Gradient? levelBarGradient,
    Gradient? streakStarGradient,
  }) =>
      ProgressThemeExtension(
        levelBarGradient: levelBarGradient,
        streakStarGradient: streakStarGradient,
      );

  @override
  ThemeExtension<ProgressThemeExtension> lerp(
    covariant ThemeExtension<ProgressThemeExtension>? other,
    double t,
  ) {
    if (other is! ProgressThemeExtension) {
      return this;
    }
    return ProgressThemeExtension(
      levelBarGradient: Gradient.lerp(
        levelBarGradient,
        other.levelBarGradient,
        t,
      ),
      streakStarGradient: Gradient.lerp(
        streakStarGradient,
        other.streakStarGradient,
        t,
      ),
    );
  }
}
