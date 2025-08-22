import 'package:arena_x/utils/widgets/custom/wd_health_battle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/models/battle_step.dart';
import '../core/state/battle_state.dart';
import '../utils/widgets/layout/wd_scaffold.dart';

class BattleRead extends StatefulWidget {
  const BattleRead({super.key});

  @override
  State<BattleRead> createState() => _BattleReadState();
}

class _BattleReadState extends State<BattleRead> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      context.read<BattleState>().createBattle();
      _started = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BattleState b = context.watch<BattleState>();
    return WdScaffold(
      title: 'Batalha',
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: WdHealthBattle(
                  title: b.player.name,
                  actualHealth: b.playerHealth,
                  maxHealth: b.player.maxHp,
                  color: Colors.green,
                ),
              ),
              Flexible(
                child: WdHealthBattle(
                  title: b.currentMonster.name,
                  actualHealth: b.monsterHealth,
                  maxHealth: b.currentMonster.maxHp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) {
                BattleStep step = b.battleLog[i];
                return ListTile(
                  title: Text(
                    step.action,
                    style: TextStyle(
                      color: step.dice == null
                          ? Colors.green
                          : step.myTurn
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  subtitle: Text(step.message),
                  leading: step.dice == null
                      ? null
                      : CircleAvatar(
                          backgroundColor: step.myTurn
                              ? Colors.blue
                              : Colors.red,
                          child: Text(
                            step.dice!.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemCount: b.battleLog.length,
            ),
          ),
          if (!b.isBattleRunning)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => b.getOut(context),
                child: const Text('Sair da Batalha'),
              ),
            ),
        ],
      ),
    );
  }
}
