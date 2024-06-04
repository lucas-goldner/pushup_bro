import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/menu/model/menu_tab_info.dart';

class MenuTab extends StatelessWidget {
  const MenuTab(
    this._drawerController,
    this._menuInfo,
    this._itemSlideInterval, {
    super.key,
  });
  final AnimationController _drawerController;
  final Interval _itemSlideInterval;
  final MenuTabInfo _menuInfo;

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
        child: GestureDetector(
          onTap: () => _menuInfo.navigate(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: [
                    Icon(_menuInfo.getIcon()),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      _menuInfo.getMenuTitle(context),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
