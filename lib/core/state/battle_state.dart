import 'dart:async';
import 'dart:math' as m;

import 'package:arena_x/core/models/battle_step.dart';
import 'package:arena_x/core/models/monster.dart';
import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/player.dart';

class BattleState extends ChangeNotifier {
  /// O objeto `Player` que representa o jogador atual.
  final Player player;

  /// Cria uma nova instância de `BattleState` usando o contexto do Flutter.
  BattleState(BuildContext context) : player = context.read<GameState>().player;

  /// Variável que define a vez do jogador na batalha.
  bool _myTurn = true;

  /// Retorna se é a vez do jogador atual.
  bool get isMyTurn => _myTurn;

  /// Lista de logs de batalha, onde cada entrada é uma string representando um evento na batalha.
  final List<BattleStep> _battleLog = [];

  /// Retorna o log de batalha atual.
  List<BattleStep> get battleLog => _battleLog;

  Timer? _battleTimer;
  Timer? get battleTimer => _battleTimer;
  bool get isBattleRunning => _battleTimer?.isActive ?? false;
  bool _resultBattle = false;
  bool get victoryFromBattle => _resultBattle;
  int dadoVariante = 0;

  /// O monstro atual que está sendo enfrentado pelo jogador.
  /// Inicialmente, é um monstro gerado aleatoriamente.
  late Monster currentMonster;

  /// Lógica para gerar um monstro aleatório
  Monster generateMonster() {
    return Monster(
      id: 'monster_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Monstro Aleatório',
      level: player.level,
      hp: 10,
      attack: 6,
      defense: 2,
      xpReward: 2,
      goldReward: 50,
    );
  }

  /// Cria uma batalha com um monstro gerado aleatoriamente para o jogador atual.
  void createBattle() {
    currentMonster = generateMonster();
    _battleLog.clear();
    _battleLog.add(
      BattleStep(
        playerHealth: player.hp,
        monsterHealth: currentMonster.hp,
        action: 'Batalha Iniciada',
        message: 'Você encontrou um ${currentMonster.name}!',
        myTurn: _myTurn,
      ),
    );
    timerBettweenRounds();
  }

  /// Inicia o temporizador de batalha, que atualiza o estado da batalha a cada segundo.
  /// Chamado quando uma batalha é criada.
  /// Notifica os ouvintes para atualizar a interface do usuário.
  /// O temporizador pode ser usado para simular o tempo entre rodadas ou ações.
  ///
  /// O combate deve ser baseado em turnos, onde o jogador e o monstro se atacam alternadamente.
  void timerBettweenRounds({Duration duration = const Duration(seconds: 1)}) {
    _battleTimer?.cancel();
    _battleTimer = Timer.periodic(duration, (timer) {
      if (currentMonster.hp <= 0) {
        _battleLog.add(
          BattleStep(
            playerHealth: player.hp,
            monsterHealth: currentMonster.hp,
            action: 'Batalha Concluída',
            message: 'Você derrotou ${currentMonster.name}!',
            myTurn: _myTurn,
          ),
        );
        _resultBattle = true;
        _battleTimer?.cancel();
      } else if (player.hp <= 0) {
        _battleLog.add(
          BattleStep(
            playerHealth: player.hp,
            monsterHealth: currentMonster.hp,
            action: 'Batalha Concluída',
            message: 'Você foi derrotado por ${currentMonster.name}!',
            myTurn: _myTurn,
          ),
        );
        _resultBattle = false;
        _battleTimer?.cancel();
      } else {
        if (_myTurn) {
          // Lógica para a vez do jogador
          final int dano = _calcularDano(
            ataque: player.attack,
            defesa: currentMonster.defense,
          );
          // Aplica o dano ao monstro
          currentMonster.hp -= dano;
          // Atualiza o log de batalha
          _battleLog.add(
            BattleStep(
              playerHealth: player.hp,
              monsterHealth: currentMonster.hp,
              action: 'Ataque',
              message:
                  'Você atacou ${currentMonster.name} e causou $dano de dano.',
              dice: dadoVariante,
              myTurn: _myTurn,
            ),
          );
          _myTurn = false; // Alterna a vez para o monstro
        } else {
          // Lógica para a vez do monstro
          final int dano = _calcularDano(
            ataque: currentMonster.attack,
            defesa: player.defense,
          );
          // Aplica o dano ao jogador
          player.hp -= dano;
          // Atualiza o log de batalha
          _battleLog.add(
            BattleStep(
              playerHealth: player.hp,
              monsterHealth: currentMonster.hp,
              action: 'Ataque',
              message:
                  '${currentMonster.name} atacou você e causou $dano de dano.',
              dice: dadoVariante,
              myTurn: _myTurn,
            ),
          );
          _myTurn = true; // Alterna a vez para o jogador
        }
      }
      notifyListeners();
    });
  }

  /// Calcula o dano causado por um ataque, levando em consideração o ataque de um jogador e a defesa do monstro, e vice versa
  /// @param ataque -> O valor de ataque do atacante.
  /// @param defesa -> O valor de defesa do defensor.
  ///
  /// Cria uma pequena variação de dano de ataque, para criar uma pequena variação no dano causado.
  /// Depois retorna o dano calculado, que é a diferença entre ataque e defesa, arredondada para baixo.
  ///
  /// Se o dano for menor que 0, retorna 0.
  /// Isso garante que o dano não seja negativo.
  int _calcularDano({required int ataque, required int defesa}) {
    final random = m.Random();
    // DADO DE RPG de 1 a 6
    dadoVariante = random.nextInt(6) + 1; // Value is >= 1 and < 7.
    late int dano;
    switch (dadoVariante) {
      case 1:
        // Defesa Alta
        dano = ataque - (defesa * 2);
        break;
      case 2:
        // Defesa Média
        dano = ataque - (defesa * 1.5).floor();
        break;
      case 3:
        // Ataque Normal
        dano = ataque - defesa;
        break;
      case 4:
        // Ataque Normal
        dano = ataque - defesa;
        break;
      case 5:
        // Ataque Alto
        dano = (ataque * 1.5).floor() - defesa;
        break;
      case 6:
        // Ataque Crítico
        dano = (ataque * 2).floor() - defesa;
        break;
    }
    if (dano < 0) {
      return 0;
    }
    return dano;
  }

  /// Finaliza a batalha e atualiza o estado do jogador com base no resultado da batalha.
  ///
  /// Se o jogador venceu, ele recebe experiência e ouro do monstro derrotado.
  /// Se o jogador perdeu, a batalha é encerrada sem recompensas.
  void getOut(BuildContext context) {
    if (_resultBattle) {
      player.addXp(currentMonster.xpReward);
      player.gold += currentMonster.goldReward;
      context.read<GameState>().notifyListeners();
    }
    Navigator.of(context).pop();
  }

  int get playerHealth => player.hp;
  int get monsterHealth => currentMonster.hp;

  /*
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
      hp: hp,
      attack: atk,
      defense: def,
      xpReward: xp,
      goldReward: gold,
    );
    return (m, hp);
  }
  */
}
