import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/progress/widgets/profile.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});
  static const routeName = '/progress';

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 128,
                    child: PBButton.icon(
                      'Share',
                      icon: CarbonIcons.share,
                      callback: () => {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Profile(name: 'Your name', imageUrl: ''),
            ],
          ),
        ),
      );
}
