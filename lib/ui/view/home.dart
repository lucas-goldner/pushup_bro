import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/common/animated_button.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';
import 'package:pushup_bro/ui/widgets/home/monkey.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void toggleListeningUpdates(BuildContext context) {
    final airpodsCubit = BlocProvider.of<AirPodsTrackerCubit>(context);
    final pushupCubit = BlocProvider.of<PushupCubit>(context);

    if (airpodsCubit.state.isListening) {
      airpodsCubit.stopListening();
      pushupCubit.resetPushups();
    } else {
      airpodsCubit.getAirPodsMotionData();
    }
  }

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

                    return Text(
                      'Pushups: ${pushupCubit.getCurrentPushups()}',
                    );
                  }

                  return const SizedBox();
                },
              ),
              const Spacer(),
              AnimatedButton(
                text: S.of(context).startPush,
                icon: CarbonIcons.arrow_right,
                callback: () => toggleListeningUpdates(context),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );
}
