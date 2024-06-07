import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/progress/view/progress.dart';
import 'package:pushup_bro/features/pushup_tracking/cubit/pushup_cubit.dart';
import 'package:pushup_bro/features/pushup_tracking/view/pushup_tracking.dart';
import 'package:pushup_bro/features/settings/view/settings.dart';

enum MenuTabInfo {
  pushupTracking,
  progress,
  // calendar,
  settings,
}

extension MenuTabInfoExtension on MenuTabInfo {
  String getMenuTitle(BuildContext context) => switch (this) {
        MenuTabInfo.pushupTracking => context.l10n.home,
        MenuTabInfo.progress => context.l10n.progress,
        // MenuTabInfo.calendar => context.l10n.calendar,
        MenuTabInfo.settings => context.l10n.settings
      };

  IconData getIcon() => switch (this) {
        MenuTabInfo.pushupTracking => CarbonIcons.home,
        MenuTabInfo.progress => CarbonIcons.skill_level,
        // MenuTabInfo.calendar => CarbonIcons.calendar,
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
      MenuTabInfo.progress => navigator.pushReplacementNamed(
          Progress.routeName,
          arguments: context,
        ),
      // MenuTabInfo.calendar => navigator.pushReplacementNamed(
      //     Calendar.routeName,
      //     arguments: context,
      //   ),
      MenuTabInfo.settings => navigator.pushReplacementNamed(
          Settings.routeName,
          arguments: context,
        ),
    };
  }
}
