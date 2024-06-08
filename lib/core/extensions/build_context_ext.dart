import 'package:flutter/material.dart';
import 'package:pushup_bro/core/style/pb_shadow.dart';
import 'package:pushup_bro/core/style/progress_theme_extensions.dart';
import 'package:pushup_bro/generated/l10n.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get sizeOf => MediaQuery.of(this).size;
  T extension<T>() => Theme.of(this).extension<T>() as T;
  ProgressThemeExtension get progressTheme =>
      extension<ProgressThemeExtension>();
  S get l10n => S.of(this);
  BoxShadow get shadow => getFinalBoxShadow(this);
}
