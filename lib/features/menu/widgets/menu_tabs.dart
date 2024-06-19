import 'package:flutter/material.dart';
import 'package:pushup_bro/features/menu/model/menu_tab_info.dart';
import 'package:pushup_bro/features/menu/widgets/menu_tab.dart';

class MenuTabs extends StatelessWidget {
  const MenuTabs(
    this.drawerController,
    this.menuTabs,
    this.itemSlideIntervals, {
    required this.open,
    super.key,
  });
  final AnimationController drawerController;
  final List<Interval> itemSlideIntervals;
  final List<MenuTabInfo> menuTabs;
  final bool open;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: !open,
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < MenuTabInfo.values.length; ++i) ...[
                MenuTab(
                  drawerController: drawerController,
                  menuInfo: menuTabs[i],
                  itemSlideInterval: itemSlideIntervals[i],
                ),
              ],
            ],
          ),
        ),
      );
}
