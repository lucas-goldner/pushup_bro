abstract class AudioPlayerService {
  Future<void> setVolumeLevel(double volume);
  Future<void> playSound(String asset);
}
