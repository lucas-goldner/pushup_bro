import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/widgets/animated_button.dart';
import 'package:pushup_bro/generated/l10n.dart';

class StartPushupsButton extends StatefulWidget {
  const StartPushupsButton(this.onButtontrigger, {super.key});
  final VoidCallback onButtontrigger;

  @override
  State<StartPushupsButton> createState() => _StartPushupsButtonState();
}

class _StartPushupsButtonState extends State<StartPushupsButton> {
  bool buttonPressed = false;

  void switchButtonState(BuildContext context) {
    widget.onButtontrigger.call();
    setState(() => buttonPressed = !buttonPressed);
  }

  @override
  Widget build(BuildContext context) => AnimatedButton(
        text: buttonPressed ? S.of(context).finishSet : S.of(context).startPush,
        icon: CarbonIcons.arrow_right,
        callback: () => switchButtonState(context),
        isPressed: buttonPressed,
      );
}
