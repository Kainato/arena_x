import 'dart:async';

import 'package:arena_x/core/box/player_box.dart';
import 'package:arena_x/core/extension/hive_extension.dart';
import 'package:arena_x/core/state/battle_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/battle_read.dart';
import '../enum/item_type.dart';
import '../models/item.dart';
import '../models/player.dart';
import '../services/cooldown_service.dart';
import '../services/loot_service.dart';

class GameState extends ChangeNotifier {
  late Player player;
  final LootService loot = LootService();
  final CooldownService cooldowns = CooldownService();
  bool _isLoadingGame = true;
  bool get isLoadingGame => _isLoadingGame;

  /// Inicializa o estado do jogo, incluindo o jogador e os cooldowns
  /// Isso deve ser chamado no início do aplicativo para garantir que o estado esteja pronto.
  Future<void> bootstrap() async {
    // Inicia o estado de carregamento do jogo
    changeLoadingGame(value: true);

    // Placeholder de usuário local
    player = Player(
      id: 'local',
      name: await HiveExtension.getString(
        boxName: PlayerBox.id.boxName,
        key: PlayerBox.jogador.boxKey,
        defaultValue: 'Aventureiro',
      ),
      level: await HiveExtension.getInt(
        boxName: PlayerBox.id.boxName,
        key: PlayerBox.nivel.boxKey,
        defaultValue: 1,
      ),
      xp: await HiveExtension.getInt(
        boxName: PlayerBox.id.boxName,
        key: PlayerBox.xp.boxKey,
        defaultValue: 0,
      ),
      gold: await HiveExtension.getInt(
        boxName: PlayerBox.id.boxName,
        key: PlayerBox.ouro.boxKey,
        defaultValue: 0,
      ),
    );
    // Nome do jogador
    HiveExtension.putString(
      boxName: PlayerBox.id.boxName,
      key: PlayerBox.jogador.boxKey,
      value: player.name,
    );
    // Prepara o controlador de texto para o nome do jogador
    playerNameController.text = player.name;
    // Nível do jogador
    HiveExtension.putInt(
      boxName: PlayerBox.id.boxName,
      key: PlayerBox.nivel.boxKey,
      value: player.level,
    );
    // XP do jogador
    HiveExtension.putInt(
      boxName: PlayerBox.id.boxName,
      key: PlayerBox.xp.boxKey,
      value: player.xp,
    );
    // Ouro do jogador
    HiveExtension.putInt(
      boxName: PlayerBox.id.boxName,
      key: PlayerBox.ouro.boxKey,
      value: player.gold,
    );
    // Finaliza o estado de carregamento do jogo
    changeLoadingGame(value: false);
    // Notifica os ouvintes sobre a mudança de estado
    notifyListeners();
  }

  /// Altera o estado de carregamento do jogo
  /// Use isso para indicar que o jogo está carregando ou não.
  void changeLoadingGame({bool? value}) {
    // Se o valor for nulo, mantém o estado atual
    _isLoadingGame = value ?? _isLoadingGame;
    // Notifica os ouvintes sobre a mudança de estado
    notifyListeners();
  }

  /// Controlador de texto para o nome do jogador
  TextEditingController playerNameController = TextEditingController();

  /// Define o nome do jogador e salva no cache
  Future<void> setPlayerName(String name) async {
    // Altera o nome do objeto do jogador
    player.name = name;
    // Salva o nome no cache
    HiveExtension.putString(
      boxName: PlayerBox.id.boxName,
      key: PlayerBox.jogador.boxKey,
      value: name,
    );
    // Notifica os ouvintes sobre a mudança
    notifyListeners();
  }

  // ignore: prefer_final_fields
  String _cdKeyExplore = 'cd_explore';

  Duration get exploreTimeLeft => cooldowns.timeLeft(_cdKeyExplore);
  bool get canExplore => cooldowns.isReady(_cdKeyExplore);

  bool _healBeforeBattle = false;

  bool get healBeforeBattle => _healBeforeBattle;

  /// Cura o jogador antes da batalha, aumentando o HP em 10
  /// Se o HP já estiver no máximo, não faz nada.
  void healSmall(BuildContext context) {
    if (healBeforeBattle) {
      if (player.hp >= player.maxHp) return;
      player.hp = (player.hp + 10).clamp(0, player.maxHp);
      _healBeforeBattle = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Curado 10 HP!'),
          backgroundColor: Colors.green,
        ),
      );
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

  void exploreAndBattle(BuildContext context) {
    if (canExplore) {
      cooldowns.setCooldown(_cdKeyExplore, const Duration(seconds: 15));
      _startCooldownTicker();

      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => BattleState(context),
            child: const BattleRead(),
          ),
        ),
      );
      _healBeforeBattle = true;
      notifyListeners();
    }
  }

  void comprarItem(BuildContext context, {required Item it}) {
    if (player.gold >= it.price) {
      player.gold -= it.price;
      player.inventory.add(it);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Item comprado: ${it.name}!')));
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ouro insuficiente para comprar ${it.name}!')),
      );
    }
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

  void unequip(BuildContext context, {required Item item}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Aviso!'),
        content: Text(
          'Deseja realmente desequipar ${item.name}? Isso não removerá o item do inventário!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            child: const Text('Desequipar'),
            onPressed: () {
              Navigator.pop(context);
              if (!player.inventory.contains(item)) return;
              switch (item.type) {
                case ItemType.weapon:
                  player.equippedWeapon = null;
                  break;
                case ItemType.armor:
                  player.equippedArmor = null;
                  break;
                case ItemType.consumable:
                  break;
              }
              notifyListeners();
            },
          ),
        ],
      ),
    );
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
