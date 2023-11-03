import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pushup_bro/core/service/audio_player_provider.dart';
import 'package:pushup_bro/features/pushups/cubit/pushup_cubit.dart';

import '../../../mock/mock_device_motion_data.dart';
import '../../../mock/service/mock_audio_player_service.dart';

void main() {
  final audioPlayer = MockAudioPlayerService();
  final deviceMotionDataMocks = DeviceMotionDataMocks();

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    when(() => audioPlayer.setVolumeLevel(any()))
        .thenAnswer((_) => Future.value());
    when(() => audioPlayer.playSound(any())).thenAnswer((_) => Future.value());
  });

  group('Test pushup cubit', () {
    group('Test pushup cubit pushup state', () {
      test(
        'Test pushup cubit init state',
        () async {
          final audioPlayer = AudioPlayerImpl();
          final pushupCubit = PushupCubit(audioPlayer);
          expect(pushupCubit.state.inPushup, false);
          expect(pushupCubit.state.pushups.length, 0);
        },
      );

      test(
        'Test pushup cubit receive downwards movement',
        () async {
          final audioPlayer = AudioPlayerImpl();
          final pushupCubit = PushupCubit(audioPlayer);
          expect(pushupCubit.state.inPushup, false);
          expect(pushupCubit.state.pushups.length, 0);
          pushupCubit.listenForPushupEvents(
            deviceMotionDataMocks.mockDownwardsMovementDeviceMotionData,
            0,
          );
          expect(pushupCubit.state.inPushup, true);
        },
      );
    });

    group('Test pushup cubit pushup state', () {
      void doPushup(PushupCubit pushupCubit) {
        expect(pushupCubit.state.inPushup, false);
        expect(pushupCubit.state.pushups.length, 0);
        pushupCubit.listenForPushupEvents(
          deviceMotionDataMocks.mockDownwardsMovementDeviceMotionData,
          0,
        );
        expect(pushupCubit.state.inPushup, true);
        pushupCubit.listenForPushupEvents(
          deviceMotionDataMocks.mockUpwardsMovementDeviceMotionData,
          0,
        );
        expect(pushupCubit.state.inPushup, false);
        expect(pushupCubit.state.pushups.length, 1);
        expect(pushupCubit.getCurrentPushups, 1);
      }

      test(
        'Test pushup cubit performs pushup',
        () async {
          final pushupCubit = PushupCubit(audioPlayer);
          doPushup(pushupCubit);
          verify(() => audioPlayer.playSound(any())).called(1);
        },
      );

      test(
        'Test pushup cubit resets after successful pushup',
        () async {
          final pushupCubit = PushupCubit(audioPlayer);
          doPushup(pushupCubit);
          final pushupSet = pushupCubit.resetAndReturnCurrentPushupSet();
          expect(pushupSet.pushups.length, 1);
          expect(pushupCubit.getCurrentPushups, 0);
        },
      );
    });
  });
}
