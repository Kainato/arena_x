import 'package:arena_x/utils/feature/inventory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/game_state.dart';
import '../../../core/models/player.dart';
import '../../../utils/widgets/wd_chip.dart';

class StatusRead extends StatelessWidget {
  const StatusRead({super.key});

  @override
  Widget build(BuildContext context) {
    final GameState game = context.watch<GameState>();
    final Player p = game.player;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            WdChip.value(
              label: 'Nível',
              value: p.level.toString(),
              avatar: Icon(Icons.person),
            ),
            WdChip.value(
              label: 'XP',
              value: '${p.xp}/${p.xpToNext}',
              avatar: Icon(Icons.star),
            ),
            WdChip.value(
              label: 'HP',
              value: '${p.hp}/${p.maxHp}',
              avatar: Icon(Icons.favorite),
            ),
            WdChip.value(
              label: 'ATK',
              value: p.totalAttack.toString(),
              avatar: Icon(Icons.circle_outlined),
            ),
            WdChip.value(
              label: 'DEF',
              value: p.totalDefense.toString(),
              avatar: Icon(Icons.shield),
            ),
            WdChip.value(
              label: 'Ouro',
              value: p.gold.toString(),
              avatar: Icon(Icons.monetization_on),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const InventoryRead(),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: game.canExplore
                    ? () async => game.exploreAndBattle(context)
                    : null,
                icon: const Icon(Icons.travel_explore),
                label: Text(
                  game.canExplore
                      ? 'Explorar (15s CD)'
                      : 'Aguardando: ${game.exploreTimeLeft.inSeconds}s',
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: game.healBeforeBattle ? () => game.healSmall() : null,
              tooltip: 'Curar 10 HP',
              icon: const Icon(Icons.healing),
            ),
          ],
        ),
      ],
    );
  }
}
