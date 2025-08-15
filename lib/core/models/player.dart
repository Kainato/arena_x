import 'item.dart';

class Player {
  final String id;
  final String name;
  int level;
  int xp;
  int xpToNext;
  int maxHp;
  int hp;
  int attack;
  int defense;
  int gold;

  Item? equippedWeapon;
  Item? equippedArmor;
  final List<Item> inventory;

  Player({
    required this.id,
    required this.name,
    this.level = 1,
    this.xp = 0,
    this.xpToNext = 50,
    this.maxHp = 40,
    this.hp = 40,
    this.attack = 6,
    this.defense = 2,
    this.gold = 50,
    List<Item>? inventory,
  }) : inventory = inventory ?? [];

  int get totalAttack => attack + (equippedWeapon?.attack ?? 0);
  int get totalDefense => defense + (equippedArmor?.defense ?? 0);

  void addXp(int amount) {
    xp += amount;
    while (xp >= xpToNext) {
      xp -= xpToNext;
      level++;
      xpToNext = (xpToNext * 1.35).ceil();
      maxHp += 6;
      attack += 2;
      defense += 1;
      hp = maxHp;
    }
  }
}
