import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_airpods/models/device_motion_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_cubit.dart';
import 'package:pushup_bro/cubit/airpods_tracker/airpods_tracker_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/widgets/common/animated_button.dart';
import 'package:pushup_bro/ui/widgets/home/home_app_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String getFormatedText(DeviceMotionData? dm) {
    if (dm == null) return '';

    final quaternionX = dm.gravity.x.toStringAsFixed(2);
    final pitch = dm.attitude.pitch.toStringAsFixed(2);
    final roll = dm.attitude.roll.toStringAsFixed(2);
    final rotationX = dm.rotationRate.x.toStringAsFixed(2);
    final rotationY = dm.rotationRate.y.toStringAsFixed(2);
    final rotationZ = dm.rotationRate.z.toStringAsFixed(2);
    final userX = dm.userAcceleration.x.toStringAsFixed(2);
    final userY = dm.userAcceleration.y.toStringAsFixed(2);
    final userZ = dm.userAcceleration.z.toStringAsFixed(2);

    return '''
    quaternionX: $quaternionX
    pitch: $pitch
    roll: $roll
    rotationX: $rotationX
    rotationY: $rotationY
    rotationZ: $rotationZ
    userAccelerationX: $userX 
    userAccelerationY: $userY 
    userAccelerationZ: $userZ
  ''';
  }

  void startListeningUpdates(BuildContext context) {
    BlocProvider.of<AirPodsTrackerCubit>(context).getAirPodsMotionData();
  }

  @override
  Widget build(BuildContext context) {
    startListeningUpdates(context);

    return CupertinoPageScaffold(
      backgroundColor: PBColors.background,
      child: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            const Spacer(),
            SizedBox(
              height: 200,
              width: 200,
              child: Assets.rive.carlosIdle.rive(fit: BoxFit.contain),
            ),
            BlocSelector<AirPodsTrackerCubit, AirPodsTrackerState,
                DeviceMotionData?>(
              selector: (state) => state.currentMotionData,
              builder: (context, deviceMotionData) => deviceMotionData != null
                  ? Text(getFormatedText(deviceMotionData))
                  : const Text('Waiting for incoming data...'),
            ),
            const Spacer(),
            AnimatedButton(
              text: S.of(context).startPush,
              icon: CarbonIcons.arrow_right,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
