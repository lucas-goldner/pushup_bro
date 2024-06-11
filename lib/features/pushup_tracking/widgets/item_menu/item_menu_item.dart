import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/core/model/booster_items.dart';

@immutable
class ItemMenuItem extends StatelessWidget {
  const ItemMenuItem({
    required this.item,
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final BoosterItems item;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.getBackgroundColor(context),
              boxShadow: [context.shadow],
            ),
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              style: IconButton.styleFrom(
                backgroundColor: item.getBackgroundColor(
                  context,
                ),
              ),
              onPressed: onPressed,
              icon: item.getIcon().image(width: 48, height: 48),
            ),
          ),
          Positioned(
            right: -8,
            bottom: -4,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.onSecondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    '1',
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
