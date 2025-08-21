class Monster {
  final String id;
  final String name;
  final int level;
  int hp;
  final int attack;
  final int defense;
  final int xpReward;
  final int goldReward;

  Monster({
    required this.id,
    required this.name,
    required this.level,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.xpReward,
    required this.goldReward,
  });
}
