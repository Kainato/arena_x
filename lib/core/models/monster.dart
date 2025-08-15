class Monster {
  final String id;
  final String name;
  final int level;
  final int maxHp;
  final int attack;
  final int defense;
  final int xpReward;
  final int goldReward;

  const Monster({
    required this.id,
    required this.name,
    required this.level,
    required this.maxHp,
    required this.attack,
    required this.defense,
    required this.xpReward,
    required this.goldReward,
  });
}
