import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/features/calendar/view/calendar.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/view/pushup_tracking.dart';
import 'package:pushup_bro/features/settings/view/settings.dart';
import 'package:pushup_bro/generated/l10n.dart';

enum MenuTabInfo { pushupTracking, calendar, settings }

extension MenuTabInfoExtension on MenuTabInfo {
  String getMenuTitle(BuildContext context) => switch (this) {
        MenuTabInfo.pushupTracking => S.of(context).home,
        MenuTabInfo.calendar => S.of(context).calendar,
        MenuTabInfo.settings => S.of(context).settings
      };

  IconData getIcon() => switch (this) {
        MenuTabInfo.pushupTracking => CarbonIcons.home,
        MenuTabInfo.calendar => CarbonIcons.calendar,
        MenuTabInfo.settings => CarbonIcons.settings,
      };

  Future<void> navigate(BuildContext context) {
    final navigator = Navigator.of(context);
    BlocProvider.of<PushupCubit>(context).resetAndReturnCurrentPushupSet();

    return switch (this) {
      MenuTabInfo.pushupTracking => navigator.pushReplacementNamed(
          PushupTracking.routeName,
          arguments: context,
        ),
      MenuTabInfo.calendar => navigator.pushReplacementNamed(
          Calendar.routeName,
          arguments: context,
        ),
      MenuTabInfo.settings => navigator.pushReplacementNamed(
          Settings.routeName,
          arguments: context,
        )
    };
  }
}
