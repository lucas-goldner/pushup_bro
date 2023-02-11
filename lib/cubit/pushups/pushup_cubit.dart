import 'package:flutter_airpods/models/device_motion_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/pushups/pushup_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';
import 'package:pushup_bro/model/pushup.dart';
import 'package:pushup_bro/provider/audio_player_provider.dart';

class PushupCubit extends Cubit<PushupState> {
  PushupCubit(this._audioPlayer)
      : super(const PushupState(pushups: [], inPushup: false));
  final AudioPlayerProvider _audioPlayer;

  int getCurrentPushups() => state.pushups.length;

  void resetPushups() => emit(const PushupState(pushups: [], inPushup: false));

  void listenForPushupEvents(DeviceMotionData? deviceMotionData) {
    final userAccelerationY = deviceMotionData?.userAcceleration.y ?? 0;

    if (state.inPushup) {
      if (_checkForUpwardsMovement(userAccelerationY)) {
        final newPushup = Pushup(DateTime.now());
        final pushups = [...state.pushups, newPushup];
        final pushupSoundFilePath =
            Assets.audio.pushupSound.replaceFirstMapped('assets/', (_) => '');
        _audioPlayer
          ..setVolumeLevel(1)
          ..playSound(pushupSoundFilePath);

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
