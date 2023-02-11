import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';
import 'package:pushup_bro/ui/widgets/home/monkey.dart';
import 'package:pushup_bro/ui/widgets/home/pushup_counter.dart';
import 'package:pushup_bro/ui/widgets/home/start_pushups_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        backgroundColor: PBColors.background,
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
              const Spacer(),
              const Monkey(),
              BlocBuilder<AirPodsTrackerCubit, AirPodsTrackerState>(
                builder: (context, airPodsState) {
                  if (airPodsState.isListening) {
                    final pushupCubit = BlocProvider.of<PushupCubit>(context)
                      ..listenForPushupEvents(
                        airPodsState.currentMotionData,
                      );

                    return PushupCounter(pushupCubit.getCurrentPushups());
                  }

                  return const SizedBox();
                },
              ),
              const Spacer(),
              const StartPushupsButton(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );
}
