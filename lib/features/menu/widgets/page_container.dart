import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/style/pb_colors.dart';
import 'package:pushup_bro/core/widgets/pb_app_bar.dart';
import 'package:pushup_bro/features/menu/model/menu_tab_info.dart';

class PageContainer extends StatefulWidget {
  const PageContainer(this.pageContent, {this.menuTab, super.key});
  final Widget pageContent;
  final MenuTabInfo? menuTab;

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  double opacityLevel = 0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 0.75 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Stack(
        children: [
          Stack(
            children: [
              IgnorePointer(
                ignoring: opacityLevel != 0,
                child: Center(
                  child: widget.pageContent,
                ),
              ),
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
              SafeArea(
                child: PBAppBar(
                  widget.menuTab?.getMenuTitle(context) ?? '',
                  _changeOpacity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
