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
