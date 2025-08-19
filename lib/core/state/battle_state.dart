import 'dart:async';

import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';

class BattleState extends ChangeNotifier {
  Timer? _battleTimer;
  Timer? get battleTimer => _battleTimer;

  void timerBettweenRounds({Duration duration = const Duration(seconds: 1)}) {
    _battleTimer?.cancel();
    _battleTimer = Timer.periodic(duration, (timer) {
      notifyListeners();
    });
  }

  List<String> log = [];

  Player player = context.read<GameState>().player;

  void exploreAndBattle() {
    final (monster, _) = battle.spawnFor(player);
    final result = battle.fight(player, monster);

    final log = <String>[];
    for (final e in result.log) {
      log.add(e.text);
    }

    if (result.playerWon) {
      player.addXp(result.xpGained);
      player.gold += result.goldGained;
      final drop = loot.rollMonsterDrop(player.level);
      if (drop != null) {
        player.inventory.add(drop);
        log.add('Você ganhou loot: ${drop.name}!');
      }
      log.add('Vitória! +${result.xpGained} XP, +${result.goldGained} ouro.');
    } else {
      // Penalidade leve
      player.gold = (player.gold - 5).clamp(0, 999999);
      player.hp = (player.maxHp * 0.6).floor();
      log.add(
        'Derrota… Você perdeu um pouco de ouro e se recuperou parcialmente.',
      );
    }
  }
}
