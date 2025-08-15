import 'package:arena_x/app/battle_read.dart';
import 'package:arena_x/app/inventory_read.dart';
import 'package:arena_x/app/shop_read.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/game_state.dart';
import '../core/models/player.dart';
import '../utils/widgets/wd_scaffold.dart';

class HomeRead extends StatelessWidget {
  const HomeRead({super.key});

  @override
  Widget build(BuildContext context) {
    final GameState game = context.watch<GameState>();
    final Player p = game.player;

    return WDScaffold.bottomNavigation(
      title: 'EPIC-like RPG',
      currentIndex: game.indexTab,
      body: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, ${p.name}!'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _StatChip(label: 'Nível', value: p.level.toString()),
                _StatChip(label: 'XP', value: '${p.xp}/${p.xpToNext}'),
                _StatChip(label: 'HP', value: '${p.hp}/${p.maxHp}'),
                _StatChip(label: 'ATK', value: p.totalAttack.toString()),
                _StatChip(label: 'DEF', value: p.totalDefense.toString()),
                _StatChip(label: 'Ouro', value: p.gold.toString()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: game.canExplore
                        ? () async {
                            final (log, _) = game.exploreAndBattle();
                            if (!context.mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BattleRead(log: log),
                              ),
                            );
                          }
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
                  onPressed: () => game.healSmall(),
                  tooltip: 'Curar 10 HP',
                  icon: const Icon(Icons.healing),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Dica: equipe armas/armaduras do inventário para aumentar ATK/DEF.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        const InventoryRead(),
        const ShopRead(),
      ],
      onTap: (i) => game.setIndex(i),
      bottomNavigationBar: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
          icon: const Icon(Icons.inventory_2),
          label: 'Inventário',
        ),
        BottomNavigationBarItem(icon: const Icon(Icons.store), label: 'Loja'),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text('$label: $value'));
  }
}
