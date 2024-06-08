import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/core/style/progress_theme_extensions.dart';
import 'package:pushup_bro/generated/fonts.gen.dart';

final theme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    onPrimary: background,
    secondary: secondaryColor,
    onSecondary: background2,
    tertiary: ternaryColor,
    onTertiary: background3,
    surface: background,
    surfaceDim: CupertinoColors.black,
    surfaceBright: CupertinoColors.white,
    inversePrimary: accentColor,
    shadow: shadowDark,
    error: CupertinoColors.destructiveRed,
  ),
  textTheme: const TextTheme(
    titleLarge: pageTitleTextStyle,
    titleMedium: secondaryPageTitleTextStyle,
    titleSmall: headerTextStyle,
    labelLarge: buttonTextStyle,
    bodyLarge: pushupTextStyle,
    bodyMedium: defaultTextStyle,
  ),
  fontFamily: FontFamily.satoshi,
  extensions: [
    ProgressThemeExtension(
      streakStarGradient: const LinearGradient(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(204, 255, 191, 0),
          Color.fromARGB(204, 224, 62, 76),
        ],
      ),
    ),
  ],
);
