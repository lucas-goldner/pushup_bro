import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/ui/styles/pb_colors.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/common/menu/closing_menu_button.dart';
import 'package:pushup_bro/ui/widgets/common/menu/menu_tab.dart';
import 'package:pushup_bro/ui/widgets/common/menu/open_menu_button.dart';

class PBAppBar extends StatefulWidget {
  const PBAppBar(this.title, {super.key});
  final String? title;

  @override
  State<PBAppBar> createState() => _PBAppBarState();
}

class _PBAppBarState extends State<PBAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  List<Widget> _menuTabs() {
    final menuTabs = <Widget>[];
    const count = 3;
    const step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      menuTabs.add(
        MenuTab(
          directionInDegrees: angleInDegrees,
          maxDistance: 112,
          progress: _expandAnimation,
          child: FloatingActionButton(
            enableFeedback: false,
            backgroundColor: PBColors.background2,
            onPressed: () {},
            child: const Icon(CarbonIcons.menu),
          ),
        ),
      );
    }

    return menuTabs;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClosingMenuButton(
                _toggle,
                open: _open,
              ),
              ..._menuTabs(),
              OpenMenuButton(
                _toggle,
                open: _open,
              ),
            ],
          ),
        ),
        Center(
          child: Visibility(
            visible: widget.title != null,
            child: Text(
              widget.title ?? '',
              style: PBTextStyles.pageTitleTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
