import 'package:flutter/material.dart';
import 'package:pushup_bro/generated/assets.gen.dart';

enum ShopBuyables {
  accessoriesShop,
  airport,
  gym,
  monkeyAdoption;

  const ShopBuyables();

  String getLocalizedName(BuildContext context) => switch (this) {
        ShopBuyables.accessoriesShop => 'Accessories Shop',
        ShopBuyables.airport => 'Airport',
        ShopBuyables.gym => 'Gym',
        ShopBuyables.monkeyAdoption => 'Monkey Adoption',
      };

  int get price => switch (this) {
        ShopBuyables.accessoriesShop => 50,
        ShopBuyables.airport => 500,
        ShopBuyables.gym => 1000,
        ShopBuyables.monkeyAdoption => 2000,
      };

  AssetGenImage get genImg => switch (this) {
        ShopBuyables.accessoriesShop => Assets.images.island.accessories,
        ShopBuyables.airport => Assets.images.island.airport,
        ShopBuyables.gym => Assets.images.island.gym,
        ShopBuyables.monkeyAdoption => Assets.images.island.monkeyAdoption,
      };
}
