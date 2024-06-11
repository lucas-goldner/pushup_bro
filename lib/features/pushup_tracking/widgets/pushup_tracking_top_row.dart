import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class PushupTrackingTopRow extends StatelessWidget {
  const PushupTrackingTopRow({
    required this.toggleNewsVisibility,
    super.key,
  });

  final VoidCallback toggleNewsVisibility;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              top: 4,
            ),
            child: IconButton(
              style: IconButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                backgroundColor: context.colorScheme.surface,
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: toggleNewsVisibility,
              icon: Icon(
                CarbonIcons.event_schedule,
                color: context.colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      );
}
