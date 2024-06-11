import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/features/pushup_tracking/model/news.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/news_banner_item.dart';

class NewsBanner extends StatefulWidget {
  const NewsBanner({super.key});

  @override
  State<NewsBanner> createState() => _NewsBannerState();
}

class _NewsBannerState extends State<NewsBanner> {
  late final PageController _controller;
  double factor = 1;

  final List<News> news = [
    News(
      title: 'Lucas gave you a boost!',
      description: 'description',
      type: NewsType.friendBoost,
      date: DateTime.now(),
    ),
    News(
      title: 'Double Bro Points Day!',
      description: 'Today you get double bro points for each pushup',
      type: NewsType.eventDay,
      date: DateTime.now(),
    ),
    News(
      title: 'New Update',
      description: 'Enjoy the new features',
      type: NewsType.update,
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 120,
        child: PageView.builder(
          itemCount: news.length,
          controller: _controller,
          itemBuilder: (context, index) => ListenableBuilder(
            listenable: _controller,
            builder: (context, child) {
              if (_controller.position.hasContentDimensions) {
                factor = 1 - (_controller.page! - index).abs();
              }

              return NewsBannerItem(
                factor: factor,
                index: index,
                news: news[index],
              );
            },
          ),
        ),
      );
}
