import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/widgets/common/animated_button.dart';

class StartPushupsButton extends StatefulWidget {
  const StartPushupsButton(this.onButtontrigger, {super.key});
  final VoidCallback onButtontrigger;

  @override
  State<StartPushupsButton> createState() => _StartPushupsButtonState();
}

class _StartPushupsButtonState extends State<StartPushupsButton> {
  bool buttonPressed = false;

  void switchButtonState(BuildContext context) {
    if (buttonPressed) {
      widget.onButtontrigger.call();
      setState(() => buttonPressed = false);
    } else {
      widget.onButtontrigger.call();
      setState(() => buttonPressed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      text: buttonPressed ? S.of(context).finishSet : S.of(context).startPush,
      icon: CarbonIcons.arrow_right,
      callback: () => switchButtonState(context),
    );
  }
}
