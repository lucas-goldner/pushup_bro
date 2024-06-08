class LevelScaler {
  static const Map<int, int> levelScaling = {
    1: 40,
    2: 60,
    3: 80,
    4: 120,
    5: 160,
  };

  num getLevelScaling(int level) => levelScaling[level] ?? 0;

  double getCurrentExperienceRelativeToLevel(
    int level,
    int currentExperience,
  ) =>
      currentExperience / getLevelScaling(level);
}
