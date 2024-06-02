import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pushup_bro/core/service/audio/audio_player_service_impl.dart';

import '../../mock/service/audio/mock_audio_player.dart';

void main() {
  final mockAudioPlayer = MockAudioPlayer();
  const mockAudioFilePath = 'assets/audio/pushup_sound.mp3';

  group('Audio player sevice test', () {
    test('Audio player service plays sound', () async {
      when(mockAudioPlayer.stop).thenAnswer((_) => Future.value());
      final audioPlayer = AudioPlayerImpl(player: mockAudioPlayer);
      await audioPlayer.playSound(mockAudioFilePath);
      verify(() => mockAudioPlayer.stop).called(1);
      // verify(() => mockAudioPlayer.play(AssetSource(mockAudioFilePath)))
      //     .called(1);
    });
  });
}
