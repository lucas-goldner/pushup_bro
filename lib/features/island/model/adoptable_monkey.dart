import 'package:isar/isar.dart';
import 'package:pushup_bro/features/island/model/shop_buyables.dart';

part 'adoptable_monkey.g.dart';

@embedded
class AdoptableMonkey {
  AdoptableMonkey({
    this.name = '',
    this.xp = 0,
    this.accessory = ShopBuyables.none,
  });

  factory AdoptableMonkey.carlos() => AdoptableMonkey(
        name: 'Carlos',
      );

  AdoptableMonkey copyWith({
    String? name,
    int? xp,
    ShopBuyables? accessory,
  }) =>
      AdoptableMonkey(
        name: name ?? this.name,
        xp: xp ?? this.xp,
        accessory: accessory ?? this.accessory,
      );

  final String name;
  final int xp;
  @Enumerated(EnumType.name)
  final ShopBuyables accessory;
}
