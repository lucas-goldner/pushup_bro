import 'package:flutter_airpods/models/device_motion_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/model/pushup.dart';
import 'package:pushup_bro/core/model/pushup_set.dart';
import 'package:pushup_bro/core/provider/audio_player_provider.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_state.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class PushupCubit extends Cubit<PushupState> {
  PushupCubit(this._audioPlayer)
      : super(const PushupState(pushups: [], inPushup: false));
  final AudioPlayerProvider _audioPlayer;

  int getCurrentPushups() => state.pushups.length;

  PushupSet resetAndReturnCurrentPushupSet() {
    final pushups = state.pushups;
    emit(const PushupState(pushups: [], inPushup: false));
    return PushupSet(pushups: pushups, effort: 0);
  }

  void listenForPushupEvents(DeviceMotionData? deviceMotionData, int volume) {
    final userAccelerationY = deviceMotionData?.userAcceleration.y ?? 0;

    if (state.inPushup) {
      if (_checkForUpwardsMovement(userAccelerationY)) {
        final newPushup = Pushup(completedAt: DateTime.now());
        final pushups = [...state.pushups, newPushup];
        final pushupSoundFilePath =
            Assets.audio.pushupSound.replaceFirstMapped('assets/', (_) => '');

        _audioPlayer
          ..setVolumeLevel(volume / 10.toDouble())
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
