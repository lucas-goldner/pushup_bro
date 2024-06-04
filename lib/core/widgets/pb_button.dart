import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

class PBButton extends StatelessWidget {
  const PBButton(this.text, {this.callback, super.key});
  final String text;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => callback?.call(),
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  text,
                  style: context.textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      );
}
