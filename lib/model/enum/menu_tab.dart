import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/generated/l10n.dart';
import 'package:pushup_bro/model/navigation_parameter.dart';
import 'package:pushup_bro/ui/view/calendar.dart';
import 'package:pushup_bro/ui/view/home.dart';

enum MenuTabInfo { home, calendar, settings, info }

extension MenuTabInfoExtension on MenuTabInfo {
  String getMenuTitle(BuildContext context) {
    switch (this) {
      case MenuTabInfo.home:
        return 'Home';
      case MenuTabInfo.calendar:
        return 'Calendar';
      case MenuTabInfo.settings:
        return 'Settings';
      case MenuTabInfo.info:
        return 'Info';
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
      case MenuTabInfo.info:
        return CarbonIcons.information;
    }
  }

  Future<void> navigate(BuildContext context) {
    final navigator = Navigator.of(context);

    switch (this) {
      case MenuTabInfo.home:
        return navigator.pushReplacementNamed(
          Home.routeName,
          arguments: NavigationParameter(S.of(context).pushupBro, context),
        );
      case MenuTabInfo.calendar:
        return navigator.pushReplacementNamed(
          Calendar.routeName,
          arguments: NavigationParameter(S.of(context).pushupBro, context),
        );
      case MenuTabInfo.settings:
        return navigator.pushReplacementNamed(
          Home.routeName,
          arguments: NavigationParameter(S.of(context).pushupBro, context),
        );
      case MenuTabInfo.info:
        return navigator.pushReplacementNamed(
          Home.routeName,
          arguments: NavigationParameter(S.of(context).pushupBro, context),
        );
    }
  }
}
