import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';
import 'package:pushup_bro/ui/widgets/home/monkey.dart';
import 'package:pushup_bro/ui/widgets/home/pushup_counter.dart';
import 'package:pushup_bro/ui/widgets/home/start_pushups_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool finished = false;

  void toggleListeningUpdates(BuildContext context) {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(context);
    final pushupCubit = BlocProvider.of<PushupCubit>(context);

    if (airpodsCubit.state.isListening) {
      airpodsCubit.stopListening();
      pushupCubit.resetPushups();
      setState(() => finished = true);
    } else {
      airpodsCubit.getAirPodsMotionData();
      setState(() => finished = false);
    }
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

                      return const SizedBox();
                    },
                  ),
                  const Spacer(),
                  StartPushupsButton(() => toggleListeningUpdates(context)),
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
