import 'package:flutter/material.dart';
import 'package:pushup_bro/model/enum/menu_tab.dart';
import 'package:pushup_bro/ui/widgets/common/menu/menu_tab.dart';

class MenuTabs extends StatefulWidget {
  const MenuTabs(
    this._drawerController,
    this._menuTabs,
    this._itemSlideIntervals, {
    super.key,
  });
  final AnimationController _drawerController;
  final List<Interval> _itemSlideIntervals;
  final List<MenuTabInfo> _menuTabs;

  @override
  State<MenuTabs> createState() => _MenuState();
}

class _MenuState extends State<MenuTabs> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < widget._menuTabs.length; ++i) ...[
              MenuTab(
                widget._drawerController,
                widget._menuTabs[i],
                widget._itemSlideIntervals[i],
              )
            ]
          ],
        ),
      );
}
