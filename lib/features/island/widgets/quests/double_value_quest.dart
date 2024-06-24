import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/widgets/pb_button.dart';
import 'package:pushup_bro/features/menu/model/routes.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class DoubleValueQuest extends StatelessWidget {
  const DoubleValueQuest({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Assets.images.island.quests.jungle.bonusPushups.image(
                width: 120,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                context.l10n.doubleValueQuest,
                style: context.textTheme.titleSmall,
              ),
            ),
            PBButton(
              context.l10n.go.toUpperCase(),
              callback: () => Navigator.of(context).pushReplacement(
                navigateToPushupTracking(context),
              ),
            ),
          ],
        ),
      );
}
