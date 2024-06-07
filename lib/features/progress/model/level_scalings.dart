class LevelScaler {
  static const Map<int, int> levelScaling = {
    1: 40,
    2: 60,
    3: 80,
    4: 120,
    5: 160,
  };

  static num getLevelScaling(int level) => levelScaling[level] ?? 0;

  double getBarWidth(int level, int currentExperience) =>
      currentExperience / getLevelScaling(level);

  int getExperienceForNextLevel(int level) {
    if (levelScaling.containsKey(level + 1)) {
      return levelScaling[level + 1] ?? 0;
    } else {
      return 0;
    }
  }
}
