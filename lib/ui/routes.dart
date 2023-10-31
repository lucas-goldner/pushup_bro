import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/features/pushups/model/pushup_set.dart';
import 'package:pushup_bro/model/enum/menu_tab.dart';
import 'package:pushup_bro/model/navigation_parameter.dart';
import 'package:pushup_bro/ui/view/calendar.dart';
import 'package:pushup_bro/ui/view/home.dart';
import 'package:pushup_bro/ui/view/onboarding.dart';
import 'package:pushup_bro/ui/view/settings.dart';
import 'package:pushup_bro/ui/widgets/common/page_container.dart';
import 'package:pushup_bro/ui/widgets/settings/subpages/language_setting.dart';
import 'package:pushup_bro/ui/widgets/settings/subpages/volume_setting.dart';

class RouteGenerator {
  Route<CupertinoPageRoute<Widget>>? onGenerateMainRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Home.routeName:
        final params = settings.arguments as NavigationParameter?;
        return _revealCircular(
          params?.context,
          const PageContainer(
            Home(),
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
      case Onboarding.routeName:
        final pushupsSet = settings.arguments as PushupSet?;
        if (pushupsSet == null) return null;
        return CupertinoPageRoute(
          builder: (context) => Onboarding(pushupsSet),
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
