abstract class AudioPlayerInterface {
  Future<void> play(String asset);
  Future<void> pause();
  Future<void> stop();
  Future<void> setVolume(double volume);
}
