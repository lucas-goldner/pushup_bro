import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/style/pb_text_styles.dart';
import 'package:pushup_bro/generated/l10n.dart';

class PushupCounter extends StatelessWidget {
  const PushupCounter(this.pushups, {super.key});
  final int pushups;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      value: pushups,
      prefix: S.of(context).pushupsCounter,
      textStyle: PBTextStyles.pushupTextStyle,
    );
  }
}
