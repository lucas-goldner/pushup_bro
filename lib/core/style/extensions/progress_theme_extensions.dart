import 'package:flutter/material.dart';

class ProgressThemeExtension extends ThemeExtension<ProgressThemeExtension> {
  ProgressThemeExtension({
    required this.streakStarGradient,
  });

  final Gradient? streakStarGradient;

  @override
  ThemeExtension<ProgressThemeExtension> copyWith({
    Gradient? levelBarGradient,
    Gradient? streakStarGradient,
  }) =>
      ProgressThemeExtension(
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
      streakStarGradient: Gradient.lerp(
        streakStarGradient,
        other.streakStarGradient,
        t,
      ),
    );
  }
}
