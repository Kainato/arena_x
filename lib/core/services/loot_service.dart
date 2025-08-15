import '../../utils/rng.dart';
import '../enum/item_type.dart';
import '../enum/rarity.dart';
import '../models/item.dart';

class LootService {
  List<Item> getCatalog() => const [
    Item(
      id: 'wpn_001',
      name: 'Espada de Bronze',
      type: ItemType.weapon,
      rarity: Rarity.common,
      attack: 3,
      price: 40,
    ),
    Item(
      id: 'arm_001',
      name: 'Armadura de Couro',
      type: ItemType.armor,
      rarity: Rarity.common,
      defense: 2,
      price: 45,
    ),
    Item(
      id: 'pot_hp_s',
      name: 'Poção de Cura Pequena',
      type: ItemType.consumable,
      rarity: Rarity.common,
      heal: 15,
      price: 20,
    ),
  ];

  Item? rollMonsterDrop(int playerLevel) {
    // Chance simples: 35% drop comum; 8% incomum; 2% raro
    final r = rollDouble();
    if (r < 0.02) {
      return Item(
        id: 'wpn_rare_$playerLevel',
        name: 'Lâmina Etérea',
        type: ItemType.weapon,
        rarity: Rarity.rare,
        attack: 7 + (playerLevel / 2).floor(),
        price: 200,
      );
    } else if (r < 0.10) {
      return Item(
        id: 'arm_uncommon_$playerLevel',
        name: 'Peitoral Reforçado',
        type: ItemType.armor,
        rarity: Rarity.uncommon,
        defense: 4 + (playerLevel / 3).floor(),
        price: 120,
      );
    } else if (r < 0.45) {
      return const Item(
        id: 'pot_hp_s',
        name: 'Poção de Cura Pequena',
        type: ItemType.consumable,
        rarity: Rarity.common,
        heal: 15,
        price: 20,
      );
    }
    return null;
  }
}
