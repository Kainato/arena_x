import 'dart:async';

import 'package:flutter/foundation.dart';

import '../enum/item_type.dart';
import '../models/item.dart';
import '../models/player.dart';
import '../services/battle_service.dart';
import '../services/cooldown_service.dart';
import '../services/loot_service.dart';

class GameState extends ChangeNotifier {
  late Player player;
  final BattleService battle = BattleService();
  final LootService loot = LootService();
  final CooldownService cooldowns = CooldownService();

  void bootstrap() {
    // Placeholder de usuário local — trocável por Firebase Auth + Firestore
    player = Player(id: 'local', name: 'Aventureiro');
  }

  // ignore: prefer_final_fields
  String _cdKeyExplore = 'cd_explore';

  Duration get exploreTimeLeft => cooldowns.timeLeft(_cdKeyExplore);
  bool get canExplore => cooldowns.isReady(_cdKeyExplore);

  bool _healBeforeBattle = false;

  bool get healBeforeBattle => _healBeforeBattle;

  void healSmall() {
    if (healBeforeBattle) {
      if (player.hp >= player.maxHp) return;
      player.hp = (player.hp + 10).clamp(0, player.maxHp);
      _healBeforeBattle = false;
      notifyListeners();
    }
  }

  Timer? _cooldownTimer;

  void _startCooldownTicker() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (canExplore) {
        _cooldownTimer?.cancel();
      }
      notifyListeners();
    });
  }

  (List<String> log, bool ended) exploreAndBattle() {
    if (!canExplore) return (['Calma! Ação em cooldown.'], true);
    cooldowns.setCooldown(_cdKeyExplore, const Duration(seconds: 15));
    _startCooldownTicker(); // <-- Adicione esta linha

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

    _healBeforeBattle = true;

    notifyListeners();
    return (log, true);
  }

  void equip(Item item) {
    if (!player.inventory.contains(item)) return;
    switch (item.type) {
      case ItemType.weapon:
        player.equippedWeapon = item;
        break;
      case ItemType.armor:
        player.equippedArmor = item;
        break;
      case ItemType.consumable:
        if (item.heal > 0) {
          player.hp = (player.hp + item.heal).clamp(0, player.maxHp);
          player.inventory.remove(item);
        }
        break;
    }
    notifyListeners();
  }

  int _indexTab = 0;

  int get indexTab => _indexTab;

  void setIndex(int i) {
    if (_indexTab != i) {
      _indexTab = i;
      notifyListeners();
    }
  }
}
