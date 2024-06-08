import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/item_menu.dart';
import 'package:pushup_bro/features/pushup_tracking/widgets/start_pushups_button.dart';

class PushupTrackingBottomRow extends StatelessWidget {
  const PushupTrackingBottomRow({
    required this.toggleListeningUpdates,
    super.key,
  });

  final VoidCallback toggleListeningUpdates;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Center(
                child: StartPushupsButton(
                  toggleListeningUpdates,
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            const Spacer(),
          ],
        ),
        const Row(
          children: [
            Spacer(),
            ItemMenu(),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}
