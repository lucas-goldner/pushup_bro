import 'package:flutter_airpods/models/device_motion_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/pushups/pushup_state.dart';
import 'package:pushup_bro/model/pushup.dart';

class PushupCubit extends Cubit<PushupState> {
  PushupCubit() : super(const PushupState(pushups: [], inPushup: false));

  void listenForPushupEvents(DeviceMotionData deviceMotionData) {
    final userAccelerationY = deviceMotionData.userAcceleration.y;

    if (state.inPushup) {
      if (_checkForUpwardsMovement(userAccelerationY)) {
        final newPushup = Pushup(DateTime.now());
        final pushups = [...state.pushups, newPushup];

        emit(
          state.copyWith(pushups: pushups, inPushup: false),
        );
      }
    } else {
      if (_checkForDownwardsMovement(userAccelerationY)) {
        emit(state.copyWith(pushups: state.pushups, inPushup: true));
      }
    }
  }

  bool _checkForDownwardsMovement(num userAccelerationY) =>
      userAccelerationY < -0.3;

  bool _checkForUpwardsMovement(num userAccelerationY) =>
      userAccelerationY > 0.3;
}
