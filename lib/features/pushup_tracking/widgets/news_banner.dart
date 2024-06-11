import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/features/pushup_tracking/model/news.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/news_banner_item.dart';

class NewsBanner extends StatefulWidget {
  const NewsBanner({
    required this.newsVisible,
    super.key,
  });

  final bool newsVisible;

  @override
  State<NewsBanner> createState() => _NewsBannerState();
}

class _NewsBannerState extends State<NewsBanner>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
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
    _pageController = PageController();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(covariant NewsBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.newsVisible == widget.newsVisible) {
      return;
    }

    if (widget.newsVisible) {
      _animController.forward(from: 0);
    } else {
      _animController.reverse(from: 1);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) => Positioned.fill(
        top: 100,
        child: ScaleTransition(
          alignment: Alignment.topCenter,
          scale: _scaleAnimation,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 120,
              child: PageView.builder(
                itemCount: news.length,
                controller: _pageController,
                itemBuilder: (context, index) => ListenableBuilder(
                  listenable: _pageController,
                  builder: (context, child) {
                    if (_pageController.position.hasContentDimensions) {
                      factor = 1 - (_pageController.page! - index).abs();
                    }

                    return NewsBannerItem(
                      factor: factor,
                      index: index,
                      news: news[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
