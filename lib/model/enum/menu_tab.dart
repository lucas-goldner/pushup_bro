import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/cubit/pushups/pushup_cubit.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/navigation_parameter.dart';
import 'package:pushup_bro/ui/view/calendar.dart';
import 'package:pushup_bro/ui/view/home.dart';
import 'package:pushup_bro/ui/view/settings.dart';

enum MenuTabInfo { home, calendar, settings }

extension MenuTabInfoExtension on MenuTabInfo {
  String getMenuTitle(BuildContext context) {
    switch (this) {
      case MenuTabInfo.home:
        return S.of(context).home;
      case MenuTabInfo.calendar:
        return S.of(context).calendar;
      case MenuTabInfo.settings:
        return S.of(context).settings;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MenuTabInfo.home:
        return CarbonIcons.home;
      case MenuTabInfo.calendar:
        return CarbonIcons.calendar;
      case MenuTabInfo.settings:
        return CarbonIcons.settings;
    }
  }

  Future<void> navigate(BuildContext context) {
    final navigator = Navigator.of(context);
    BlocProvider.of<PushupCubit>(context).resetAndReturnCurrentPushupSet();

    switch (this) {
      case MenuTabInfo.home:
        return navigator.pushReplacementNamed(
          Home.routeName,
          arguments: NavigationParameter(context),
        );
      case MenuTabInfo.calendar:
        return navigator.pushReplacementNamed(
          Calendar.routeName,
          arguments: NavigationParameter(context),
        );
      case MenuTabInfo.settings:
        return navigator.pushReplacementNamed(
          Settings.routeName,
          arguments: NavigationParameter(context),
        );
    }
  }
}
