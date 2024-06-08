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
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item.getBackgroundColor(),
          boxShadow: [context.shadow],
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: item.getIcon().image(width: 48, height: 48),
          color: context.colorScheme.onSecondary,
        ),
      );
}
