import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/airpods_tracker_state.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/finished_set_bottom_sheet.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/monkey.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/pushup_counter.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/pushup_tracking_bottom_row.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class PushupTracking extends StatefulWidget {
  const PushupTracking({super.key});
  static const routeName = '/';

  @override
  State<PushupTracking> createState() => _PushupTrackingState();
}

class _PushupTrackingState extends State<PushupTracking> {
  bool finished = false;
  bool started = false;

  void toggleListeningUpdates() {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(context);
    final pushupCubit = BlocProvider.of<PushupCubit>(context);

    if (started && pushupCubit.getCurrentPushups() >= 1) {
      airpodsCubit.stopListening();
      final pushups = pushupCubit.resetAndReturnCurrentPushupSet();
      setState(() {
        finished = true;
        started = false;
      });
      openBottomSheet(pushups);
    } else {
      airpodsCubit.getAirPodsMotionData();
      setState(() {
        finished = false;
        started = true;
      });
    }
  }

  Future<void> openBottomSheet(PushupSet pushups) async {
    // final navigator = Navigator.of(context);
    // final firstPushupCompleted =
    await showCupertinoModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => FinishedSetBottomSheet(pushups),
    );
    // ?? false;
    // TODO(Implement-onboarding): Reenable onboarding and finish feature
    // if (!firstPushupCompleted) {
    //   await navigator.pushNamed(
    //     Onboarding.routeName,
    //     arguments: PushupSet([], 0),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: BlocProvider.of<SharedPreferencesCubit>(context).getVolume(),
        builder: (context, future) => Stack(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Spacer(flex: 3),
                        const Monkey(),
                        BlocBuilder<AirPodsTrackerCubit, AirPodsTrackerState>(
                          builder: (context, airPodsState) {
                            if (airPodsState.isListening && started) {
                              final pushupCubit =
                                  BlocProvider.of<PushupCubit>(context)
                                    ..listenForPushupEvents(
                                      airPodsState.currentMotionData,
                                      future.data ?? 10,
                                    );

                              return PushupCounter(
                                pushupCubit.getCurrentPushups(),
                              );
                            }

                            if (started) {
                              return Text(
                                context.l10n.lookingForAirpods,
                                style: context.textTheme.bodyMedium,
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                        const Spacer(flex: 2),
                        PushupTrackingBottomRow(
                          toggleListeningUpdates: toggleListeningUpdates,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (finished)
              IgnorePointer(
                child: Assets.rive.confetti.rive(),
              ),
          ],
        ),
      );
}
