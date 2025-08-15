import '../models/player.dart';
import '../models/monster.dart';
import '../../utils/rng.dart';

class BattleLogEntry {
  final String text;
  BattleLogEntry(this.text);
}

class BattleResult {
  final bool playerWon;
  final int xpGained;
  final int goldGained;
  final List<BattleLogEntry> log;
  BattleResult({
    required this.playerWon,
    required this.xpGained,
    required this.goldGained,
    required this.log,
  });
}

class BattleService {
  (Monster, int) spawnFor(Player p) {
    final lvl = p.level + (roll(0, 100) < 30 ? 1 : 0); // 30% +1 nível
    final hp = 28 + lvl * 6;
    final atk = 5 + lvl * 2;
    final def = 2 + lvl;
    final xp = 18 + lvl * 6;
    final gold = 10 + lvl * 4;
    final m = Monster(
      id: 'mob_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Slime Sombrio',
      level: lvl,
      maxHp: hp,
      attack: atk,
      defense: def,
      xpReward: xp,
      goldReward: gold,
    );
    return (m, hp);
  }

  int _calcDamage(int attack, int defense) {
    final base = attack - (defense / 2).floor();
    final variance = roll(-2, 2);
    return (base + variance).clamp(1, 9999);
  }

  BattleResult fight(Player player, Monster monster) {
    int pHp = player.hp;
    int mHp = monster.maxHp;
    final log = <BattleLogEntry>[];

    bool playerTurn = true;
    while (pHp > 0 && mHp > 0 && log.length < 100) {
      if (playerTurn) {
        final dmg = _calcDamage(player.totalAttack, monster.defense);
        mHp -= dmg;
        log.add(
          BattleLogEntry(
            'Você atacou ${monster.name} e causou $dmg de dano. (HP monstro: ${mHp.clamp(0, 9999)})',
          ),
        );
      } else {
        final dmg = _calcDamage(monster.attack, player.totalDefense);
        pHp -= dmg;
        log.add(
          BattleLogEntry(
            '${monster.name} te acertou e causou $dmg de dano. (Seu HP: ${pHp.clamp(0, 9999)})',
          ),
        );
      }
      playerTurn = !playerTurn;
    }

    final won = pHp > 0;
    int xp = 0;
    int gold = 0;
    if (won) {
      xp = monster.xpReward;
      gold = monster.goldReward;
    }

    return BattleResult(
      playerWon: won,
      xpGained: xp,
      goldGained: gold,
      log: log,
    );
  }
}
