import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/home/finished_set_bottom_sheet.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';
import 'package:pushup_bro/ui/widgets/home/monkey.dart';
import 'package:pushup_bro/ui/widgets/home/pushup_counter.dart';
import 'package:pushup_bro/ui/widgets/home/start_pushups_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool finished = false;
  bool started = false;

  void toggleListeningUpdates(BuildContext ogContext) {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(ogContext);
    final pushupCubit = BlocProvider.of<PushupCubit>(ogContext);

    // Replace again
    // started && pushupCubit.getCurrentPushups() >= 1
    if (started) {
      airpodsCubit.stopListening();
      pushupCubit.resetPushups();
      setState(() => {finished = true, started = false});
      openBottomSheet(ogContext);
    } else {
      airpodsCubit.getAirPodsMotionData();
      setState(() => {finished = false, started = true});
    }
  }

  void openBottomSheet(BuildContext ogContext) {
    showCupertinoModalBottomSheet<Widget>(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => const FinishedSetBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        backgroundColor: PBColors.background,
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const HomeAppBar(),
                  const Spacer(),
                  const Monkey(),
                  BlocBuilder<AirPodsTrackerCubit, AirPodsTrackerState>(
                    builder: (context, airPodsState) {
                      if (airPodsState.isListening) {
                        final pushupCubit =
                            BlocProvider.of<PushupCubit>(context)
                              ..listenForPushupEvents(
                                airPodsState.currentMotionData,
                              );

                        return PushupCounter(pushupCubit.getCurrentPushups());
                      }

                      if (started) {
                        return const Text('Looking for airpods');
                      }

                      return const SizedBox();
                    },
                  ),
                  const Spacer(),
                  StartPushupsButton(() => openBottomSheet(context)),
                  const SizedBox(
                    height: 40,
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
