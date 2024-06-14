import 'package:flutter_test/flutter_test.dart';
import 'package:pushup_bro/features/progress/model/level_scalings.dart';

void main() {
  final levelScaler = LevelScaler();

  group('LevelScaler', () {
    test('getLevelScaling returns correct values', () {
      expect(levelScaler.getLevelScaling(1), 40);
      expect(levelScaler.getLevelScaling(2), 60);
      expect(levelScaler.getLevelScaling(3), 80);
      expect(levelScaler.getLevelScaling(4), 120);
      expect(levelScaler.getLevelScaling(5), 160);
    });

    test('getLevelScaling returns 0 for undefined levels', () {
      expect(levelScaler.getLevelScaling(0), 0);
      expect(levelScaler.getLevelScaling(6), 0);
      expect(levelScaler.getLevelScaling(-1), 0);
    });

    test('getCurrentExperienceRelativeToLevel returns correct ratio', () {
      expect(
        levelScaler.getCurrentExperienceRelativeToLevel(1, 20),
        closeTo(0.5, 0.0001),
      );
      expect(
        levelScaler.getCurrentExperienceRelativeToLevel(2, 30),
        closeTo(0.5, 0.0001),
      );
      expect(
        levelScaler.getCurrentExperienceRelativeToLevel(3, 40),
        closeTo(0.5, 0.0001),
      );
      expect(
        levelScaler.getCurrentExperienceRelativeToLevel(4, 60),
        closeTo(0.5, 0.0001),
      );
      expect(
        levelScaler.getCurrentExperienceRelativeToLevel(5, 80),
        closeTo(0.5, 0.0001),
      );
    });

    test('getCurrentExperienceRelativeToLevel returns correct ratio for cases',
        () {
      expect(levelScaler.getCurrentExperienceRelativeToLevel(1, 0), 0);
      expect(levelScaler.getCurrentExperienceRelativeToLevel(1, 40), 1);
      expect(levelScaler.getCurrentExperienceRelativeToLevel(2, 60), 1);
      expect(levelScaler.getCurrentExperienceRelativeToLevel(3, 80), 1);
      expect(levelScaler.getCurrentExperienceRelativeToLevel(4, 120), 1);
      expect(levelScaler.getCurrentExperienceRelativeToLevel(5, 160), 1);
    });
  });
}
