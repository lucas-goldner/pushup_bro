import 'package:pushup_bro/core/model/booster_items.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/features/pushup_tracking/model/news.dart';

List<News> getNewsForDay(int day) => switch (day) {
      1 => [],
      2 => [
          News(
            title: 'Lucas gave you a boost!',
            description: 'description',
            type: NewsType.friendBoost,
            date: DateTime.now(),
          ),
        ],
      3 => [
          News(
            title: 'Double Bro Points Day!',
            description: 'Today you get double bro points for each pushup',
            type: NewsType.doublePoinstEvent,
            date: DateTime.now(),
          ),
        ],
      _ => [],
    };

List<BoosterItems> getItemsForDay(int day) => switch (day) {
      1 => [],
      2 => [
          BoosterItems.doublePoints,
        ],
      3 => [
          BoosterItems.friendBoost,
        ],
      _ => [],
    };

int getStreakForDay(int day) => switch (day) {
      1 => 1,
      2 => 2,
      3 => 3,
      _ => 1,
    };

const _lucasImage =
    'https://media.discordapp.net/attachments/1229873636845031554/1254926758495654069/5be.jpeg?ex=667b451e&is=6679f39e&hm=5cb86b48e7c515fca2dad149a25c33167a9718b57c62f71a3c8a2f44399c5531&=&format=webp';

List<Friend> openChallengesBrosAtDay(int day) => switch (day) {
      1 => [],
      2 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 31,
            sharedStreak: 1,
          ),
        ],
      3 => [],
      _ => [],
    };

List<Friend> brosForDay(int day) => switch (day) {
      1 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 30,
          ),
        ],
      2 => [],
      3 => [
          Friend(
            id: '1',
            name: 'Lucas',
            image: _lucasImage,
            streak: 31,
            sharedStreak: 2,
          ),
        ],
      _ => [],
    };
