import '../enum/item_type.dart';
import '../enum/rarity.dart';

class Item {
  final String id;
  final String name;
  final ItemType type;
  final Rarity rarity;
  final int attack;
  final int defense;
  final int heal;
  final int price;

  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.rarity,
    this.attack = 0,
    this.defense = 0,
    this.heal = 0,
    this.price = 0,
  });
}
