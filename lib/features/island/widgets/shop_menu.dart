import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/island/model/shop_buyables.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

class ShopMenu extends StatelessWidget {
  const ShopMenu({
    required this.onQuestMenuOpen,
    super.key,
  });

  final VoidCallback onQuestMenuOpen;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ShopBuyables.values
              .map(
                (buyable) => GestureDetector(
                  onTap: onQuestMenuOpen,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                    ),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          buyable.genImg.image(
                            width: 100,
                          ),
                          Text(
                            buyable.getLocalizedName(context),
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                buyable.price.toString(),
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Assets.images.island.banana.image(
                                width: 48,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
