import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';

sealed class PBButton extends StatelessWidget {
  const factory PBButton(
    String text, {
    VoidCallback? callback,
  }) = _PBButton;

  const PBButton._({super.key});

  const factory PBButton.icon(
    String text, {
    required IconData icon,
    VoidCallback? callback,
  }) = _PBButtonIcon;
}

class _PBButton extends PBButton {
  const _PBButton(
    this.text, {
    this.callback,
  }) : super._();

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

class _PBButtonIcon extends PBButton {
  const _PBButtonIcon(
    this.text, {
    required this.icon,
    this.callback,
  }) : super._();

  final String text;
  final IconData icon;
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
                child: Row(
                  children: [
                    Text(
                      text,
                      style: context.textTheme.labelLarge,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Icon(
                        icon,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
