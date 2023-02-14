import 'package:flutter/material.dart';
import 'package:pushup_bro/generated/fonts.gen.dart';

class PBTextStyles {
  static const pushupTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w700,
    fontSize: 32,
  );

  static const pageTitleTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  static const secondaryPageTitleTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    decoration: TextDecoration.underline,
  );

  static const headerTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const buttonTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const defaultTextStyle = TextStyle(
    fontFamily: FontFamily.satoshi,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
}
