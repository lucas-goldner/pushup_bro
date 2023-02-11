import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/widgets/common/animated_button.dart';

class StartPushupsButton extends StatefulWidget {
  const StartPushupsButton({super.key});

  @override
  State<StartPushupsButton> createState() => _StartPushupsButtonState();
}

class _StartPushupsButtonState extends State<StartPushupsButton> {
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleListeningUpdates(BuildContext context) {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(context);
    final pushupCubit = BlocProvider.of<PushupCubit>(context);

    if (airpodsCubit.state.isListening) {
      airpodsCubit.stopListening();
      pushupCubit.resetPushups();
      setState(() => buttonPressed = false);
    } else {
      airpodsCubit.getAirPodsMotionData();
      setState(() => buttonPressed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      text: buttonPressed ? S.of(context).finishSet : S.of(context).startPush,
      icon: CarbonIcons.arrow_right,
      callback: () => toggleListeningUpdates(context),
    );
  }
}
