import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/widgets/page_container.dart';
import 'package:pushup_bro/features/calendar/view/calendar.dart';
import 'package:pushup_bro/features/menu/model/menu_tab_info.dart';
import 'package:pushup_bro/features/menu/model/navigation_parameter.dart';
import 'package:pushup_bro/features/pushup_tracking/view/pushup_tracking.dart';
import 'package:pushup_bro/features/settings/view/settings.dart';
import 'package:pushup_bro/features/settings/view/settings_language.dart';
import 'package:pushup_bro/features/settings/view/settings_volume.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case PushupTracking.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          const PageContainer(
            PushupTracking(),
            menuTab: MenuTabInfo.home,
          ),
        );
      case Calendar.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          const PageContainer(
            Calendar(),
            menuTab: MenuTabInfo.calendar,
          ),
        );
      case Settings.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          const PageContainer(
            Settings(),
            menuTab: MenuTabInfo.settings,
          ),
        );
      case LanguageSetting.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LanguageSetting(),
        );
      case VolumeSetting.routeName:
        return CupertinoPageRoute(
          builder: (context) => const VolumeSetting(),
        );
    }

    return null;
  }

  Route<CupertinoPageRoute<Widget>>? _revealCircular(
    BuildContext? context,
    Widget widget,
  ) {
    if (context == null) {
      return CupertinoPageRoute(
        builder: (context) => widget,
      );
    }
    return CircularClipRoute(
      expandFrom: context,
      builder: (_) => widget,
    );
  }
}
