import 'package:flutter/material.dart';

class MenuTabs extends StatefulWidget {
  const MenuTabs(
    this._drawerController,
    this._menuTitles,
    this._itemSlideIntervals, {
    super.key,
  });
  final AnimationController _drawerController;
  final List<Interval> _itemSlideIntervals;
  final List<String> _menuTitles;

  @override
  State<MenuTabs> createState() => _MenuState();
}

class _MenuState extends State<MenuTabs> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[];
    for (var i = 0; i < widget._menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: widget._drawerController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              widget._itemSlideIntervals[i]
                  .transform(widget._drawerController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Text(
              widget._menuTitles[i],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: listItems,
    );
  }
}
