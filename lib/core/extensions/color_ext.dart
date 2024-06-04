import 'package:flutter/cupertino.dart';

extension ColorExtensions on Color {
  Color darken(int amount) {
    return Color.fromRGBO(
      red - amount < 0 ? 0 : red - amount,
      green - amount < 0 ? 0 : green - amount,
      blue - amount < 0 ? 0 : blue - amount,
      opacity,
    );
  }
}
