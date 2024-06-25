import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/widgets/animated_button.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_state.dart';

class StartPushupsButton extends StatelessWidget {
  const StartPushupsButton({
    required this.onTap,
    required this.started,
    super.key,
  });

  final VoidCallback onTap;
  final bool started;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AirPodsTrackerCubit, AirPodsTrackerState>(
        builder: (context, state) => AnimatedButton(
          text: started && state.isListening
              ? context.l10n.finishSet
              : context.l10n.startPush,
          icon: CarbonIcons.arrow_right,
          callback: onTap,
          isPressed: started,
        ),
      );
}
