import 'package:audioplayers/audioplayers.dart';
import 'package:pushup_bro/core/service/audio/audio_player_service.dart';

class AudioPlayerImpl implements AudioPlayerService {
  AudioPlayerImpl({AudioPlayer? player}) : _player = player ?? AudioPlayer();
  final AudioPlayer _player;

  @override
  Future<void> playSound(String asset) async {
    await _player.stop();
    // await _player.play(AssetSource(asset));
  }

  @override
  Future<void> setVolumeLevel(double volume) async => _player.setVolume(volume);
}
