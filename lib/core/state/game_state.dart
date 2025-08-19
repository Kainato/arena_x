import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/battle_read.dart';
import '../enum/cache_keys.dart';
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
  bool _isLoadingGame = true;
  bool get isLoadingGame => _isLoadingGame;

  /// Inicializa o estado do jogo, incluindo o jogador e os cooldowns
  /// Isso deve ser chamado no início do aplicativo para garantir que o estado esteja pronto.
  Future<void> bootstrap() async {
    // Inicia o estado de carregamento do jogo
    changeLoadingGame(value: true);
    // Carrega o estado do jogador do cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Placeholder de usuário local — trocável por Firebase Auth + Firestore
    player = Player(
      id: 'local',
      name: prefs.getString(CacheKeys.jogador.key) ?? CacheKeys.jogador.key,
      level: prefs.getInt(CacheKeys.nivel.key) ?? 1,
      xp: prefs.getInt(CacheKeys.xp.key) ?? 0,
      gold: prefs.getInt(CacheKeys.ouro.key) ?? 50,
    );
    // Nome do jogador
    prefs.setString(CacheKeys.jogador.key, player.name);
    // Prepara o controlador de texto para o nome do jogador
    playerNameController.text = player.name;
    // Nível do jogador
    prefs.setInt(CacheKeys.nivel.key, player.level);
    // XP do jogador
    prefs.setInt(CacheKeys.xp.key, player.xp);
    // Ouro do jogador
    prefs.setInt(CacheKeys.ouro.key, player.gold);
    // Finaliza o estado de carregamento do jogo
    changeLoadingGame(value: false);
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

  /// Se o nome não for nulo e não estiver vazio, define o controlador de texto
  /// Caso contrário, define um nome padrão
  ///
  /// Isso garante que o nome do jogador seja carregado corretamente na interface
  /// e evita que o campo fique vazio.
  Future<void> getPlayerName() async {
    // Carrega o estado do jogador do cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Carrega o nome do jogador do cache
    String? name = prefs.getString(CacheKeys.jogador.key);

    // Se o nome não for nulo e não estiver vazio, define o controlador de texto
    // Caso contrário, define um nome padrão
    if (name != null && name.isNotEmpty) {
      playerNameController.text = name;
    } else {
      playerNameController.text = CacheKeys.jogador.key;
    }
  }

  /// Define o nome do jogador e salva no cache
  Future<void> setPlayerName(String name) async {
    // Carrega o estado do jogador do cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Altera o nome do objeto do jogador
    player.name = name;
    // Salva o nome no cache
    prefs.setString(CacheKeys.jogador.key, name);
    // Notifica os ouvintes sobre a mudança
    notifyListeners();
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

  void exploreAndBattle(BuildContext context) {
    if (canExplore) {
      cooldowns.setCooldown(_cdKeyExplore, const Duration(seconds: 15));
      _startCooldownTicker();

      if (!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => BattleRead()));

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
