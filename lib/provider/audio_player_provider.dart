import 'package:audioplayers/audioplayers.dart';
import 'package:pushup_bro/provider/interface/audio_player_interface.dart';

class AudioPlayerProvider implements AudioPlayerInterface {
  AudioPlayerProvider(this.player);
  final AudioPlayer player;

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> play(String asset) async {
    await player.play(DeviceFileSource(asset));
  }

  @override
  Future<void> stop() async {
    await player.stop();
  }

  @override
  Future<void> setVolume(double volume) async {
    await player.setVolume(volume);
  }
}
