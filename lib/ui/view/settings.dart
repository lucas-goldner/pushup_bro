import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/provider/url_launch_provider.dart';
import 'package:pushup_bro/ui/styles/pb_text_styles.dart';
import 'package:pushup_bro/ui/widgets/settings/info_item.dart';
import 'package:pushup_bro/ui/widgets/settings/settings_item.dart';
import 'package:pushup_bro/ui/widgets/settings/subpages/language_setting.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static const routeName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _launchProvider = UrlLauncherProvider(const UrlLauncherService());

  void openBrowser(Uri uri) => _launchProvider.launchUri(uri);

  Uri createURI(String path) => Uri(scheme: 'https', path: path);

  void navigateToSettingPage(String routeName) =>
      Navigator.of(context).pushNamed(routeName);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'General',
                style: PBTextStyles.headerTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Settingsitem(
              'Switch language',
              CarbonIcons.language,
              () => navigateToSettingPage(LanguageSetting.routeName),
            ),
            const SizedBox(
              height: 8,
            ),
            Settingsitem(
              'Set volume',
              CarbonIcons.volume_up,
              () => navigateToSettingPage(LanguageSetting.routeName),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Info',
                style: PBTextStyles.headerTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InfoItem(
              'Website',
              CarbonIcons.explore,
              () => openBrowser(createURI('lucas-goldner.com')),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              'Twitter',
              CarbonIcons.logo_twitter,
              () => openBrowser(createURI('twitter.lucas-goldner.com')),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              'Privacy Policy',
              CarbonIcons.virtual_private_cloud,
              () => openBrowser(createURI('lucas-goldner.com')),
            ),
            const SizedBox(
              height: 8,
            ),
            InfoItem(
              'Terms of Service',
              CarbonIcons.term,
              () => openBrowser(createURI('lucas-goldner.com')),
            ),
            const SizedBox(
              height: 8,
            ),
            // TODO(Credits): Reenable credits
            // InfoItem(
            //   'Credits',
            //   CarbonIcons.credentials,
            //   () => openBrowser(createURI('lucas-goldner.com')),
            // ),
          ],
        ),
      );
}
