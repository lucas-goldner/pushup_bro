import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';

class MenuTab extends StatelessWidget {
  const MenuTab(
    this._drawerController,
    this._title,
    this._itemSlideInterval, {
    super.key,
  });
  final AnimationController _drawerController;
  final Interval _itemSlideInterval;
  final String _title;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _drawerController,
        builder: (context, child) {
          final animationPercent = Curves.easeOut.transform(
            _itemSlideInterval.transform(_drawerController.value),
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
        child: Transform(
          transform: Matrix4.skewY(-0.25),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: PBColors.background2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  _title,
                  style: PBTextStyles.headerTextStyle
                      .copyWith(color: CupertinoColors.white),
                ),
              ),
            ),
          ),
        ),
      );
}
