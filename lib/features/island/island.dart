import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/shared_preferences_cubit.dart';
import 'package:pushup_bro/features/island/model/game_menu_type.dart';
import 'package:pushup_bro/features/island/model/quest_type.dart';
import 'package:pushup_bro/features/island/widgets/beach_overlay.dart';
import 'package:pushup_bro/features/island/widgets/game_menu.dart';
import 'package:pushup_bro/features/island/widgets/game_objects/shop.dart';
import 'package:pushup_bro/features/island/widgets/grass_overlay.dart';
import 'package:pushup_bro/features/island/widgets/ground.dart';
import 'package:pushup_bro/features/island/widgets/island_top_bar.dart';
import 'package:pushup_bro/features/island/widgets/quest_dialog.dart';
import 'package:pushup_bro/features/island/widgets/walking_monkey.dart';

class Island extends StatefulWidget {
  const Island({super.key});
  static const routeName = '/island';

  @override
  State<Island> createState() => _IslandState();
}

class _IslandState extends State<Island> {
  bool _menuVisible = false;
  GameMenuType _gameMenuType = GameMenuType.shop;
  bool _firstTimeVisiting = false;

  void toggleMenu() => setState(() => _menuVisible = !_menuVisible);
  void setMenu(GameMenuType gameMenuType) =>
      setState(() => _gameMenuType = gameMenuType);
  void firstTimeVisiting() {
    print('First time visiting');
    setState(() {
      _firstTimeVisiting = false;
      _menuVisible = false;
    });
    context
        .read<SharedPreferencesCubit>()
        .setFirstTimeIslandVisited(isFirstVisit: false);
  }

  @override
  void initState() {
    super.initState();
    _firstTimeVisiting =
        context.read<SharedPreferencesCubit>().state.firstTimeIslandVisited ??
            true;

    print('First time visiting: $_firstTimeVisiting');
    if (_firstTimeVisiting) {
      _menuVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          const Ground(),
          const GrassOverlay(),
          const BeachOverlay(),
          const WalkingMonkey(),
          Shop(
            onQuestMenuOpen: toggleMenu,
          ),
          GameMenu(
            onQuestMenuOpen: toggleMenu,
            menuVisible: _menuVisible,
            menuType: _gameMenuType,
          ),
          if (!_firstTimeVisiting || _menuVisible) const IslandTopBar(),
          if (_firstTimeVisiting)
            QuestDialog(
              questVisible: _menuVisible,
              onClose: firstTimeVisiting,
              questType: QuestType.intro,
            ),
        ],
      );
}
