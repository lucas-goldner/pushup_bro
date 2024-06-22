import 'package:flutter/widgets.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class AccessoriesShop extends StatelessWidget {
  const AccessoriesShop({super.key});

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned(
            bottom: 180,
            left: -10,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child: Assets.images.island.accessories.image(
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.colorScheme.surfaceDim,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  'Accessories'.toUpperCase(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      );
}
