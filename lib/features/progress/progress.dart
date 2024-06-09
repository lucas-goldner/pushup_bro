import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/progress/widgets/profile.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});
  static const String routeName = '/progress';

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  int selectedTab = 0;

  final List<LeaderBoardUser> leaderBoardUsers = [
    ...List.generate(
      100,
      (index) => LeaderBoardUser(
        name: 'User $index',
        image: 'https://picsum.photos/200',
        progress: (level: 0, points: 0),
      ),
    ),
  ];

  void changeTab(int index) => setState(() => selectedTab = index);

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Profile(name: 'Your name', imageUrl: ''),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Spacer(),
                  Flexible(
                    child: PBButton.icon(
                      context.l10n.shareProfile,
                      icon: CarbonIcons.share,
                      callback: () => {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
