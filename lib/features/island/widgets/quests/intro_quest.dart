import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class IntroQuest extends StatefulWidget {
  const IntroQuest({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;

  @override
  State<IntroQuest> createState() => _IntroQuestState();
}

class _IntroQuestState extends State<IntroQuest> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView(
        controller: _pageController,
        children: [
          _buildPage(
            text: context.l10n.introQuestOne,
            image: Assets.images.island.quests.intro.part1.image(
              width: 160,
              height: 160,
            ),
          ),
          _buildPage(
            text: context.l10n.introQuestTwo,
            image: Assets.images.island.quests.intro.part2.image(
              width: 160,
              height: 160,
            ),
          ),
          _buildPage(
            text: context.l10n.introQuestThree,
            image: Assets.images.island.quests.intro.part3.image(
              width: 160,
              height: 160,
            ),
            showArrow: false,
          ),
        ],
      );

  Widget _buildPage({
    required String text,
    required Widget image,
    bool showArrow = true,
  }) =>
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              image,
              const SizedBox(
                height: 16,
              ),
              Text(
                text,
                textAlign: TextAlign.left,
                style: context.textTheme.titleSmall,
              ),
              if (showArrow)
                GestureDetector(
                  onTap: () => setState(() {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }),
                  child: const Icon(
                    CarbonIcons.arrow_right,
                    size: 32,
                    color: Colors.white,
                  ),
                )
              else
                PBButton(
                  'Help Carlos!',
                  callback: widget.onClose,
                ),
            ],
          ),
        ),
      );
}
