import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/state/battle_state.dart';
import '../utils/widgets/wd_scaffold.dart';

class BattleRead extends StatelessWidget {
  const BattleRead({super.key});

  @override
  Widget build(BuildContext context) {
    final b = context.watch<BattleState>();
    b.timerBettweenRounds();
    return WdScaffold(
      title: 'Batalha',
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) => Text('• ${log[i]}'),
        separatorBuilder: (_, __) => const Divider(height: 16),
        itemCount: log.length,
      ),
    );
  }
}
