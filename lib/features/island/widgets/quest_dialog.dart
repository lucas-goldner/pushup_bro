import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/island/model/quest_type.dart';
import 'package:pushup_bro/features/island/widgets/quests/intro_quest.dart';

class QuestDialog extends StatelessWidget {
  const QuestDialog({
    required this.questVisible,
    required this.onClose,
    required this.questType,
    super.key,
  });

  final bool questVisible;
  final VoidCallback onClose;
  final QuestType questType;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: questVisible,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Positioned.fill(
              top: 200,
              left: 50,
              right: 50,
              bottom: 200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.gameColorsTheme.map,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Text(
                            questType.getLocalizedTitle(context),
                            style: context.textTheme.bodyLarge,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 8),
                      ],
                    ),
                    Expanded(
                      child: switch (questType) {
                        QuestType.intro => IntroQuest(onClose: onClose),
                        _ => const SizedBox.shrink()
                      },
                    ),
                    if (questType != QuestType.intro)
                      Row(
                        children: [
                          const Spacer(),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: onClose,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    'Close',
                                    style: context.textTheme.displaySmall
                                        ?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
