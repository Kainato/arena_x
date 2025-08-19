import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/game_state.dart';
import '../core/models/item.dart';
import '../utils/widgets/wd_chip.dart';

class ShopRead extends StatelessWidget {
  const ShopRead({super.key});

  @override
  Widget build(BuildContext context) {
    final GameState g = context.watch<GameState>();
    final List<Item> catalog = g.loot.getCatalog();

    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            WdChip.value(
              label: 'Nível',
              value: g.player.level.toString(),
              avatar: Icon(Icons.person),
            ),
            WdChip.value(
              label: 'Ouro',
              value: g.player.gold.toString(),
              avatar: Icon(Icons.monetization_on),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemCount: catalog.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final Item it = catalog[i];
              return ListTile(
                title: Text(it.name),
                subtitle: Text(
                  'ATK +${it.attack} DEF +${it.defense} Cura +${it.heal}',
                ),
                trailing: ElevatedButton(
                  onPressed: _onComprar(context, g, it),
                  child: Text('Comprar (R\$ ${it.price})'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  VoidCallback? _onComprar(BuildContext context, GameState g, Item it) {
    if (g.player.gold < it.price) return null;
    return () => g.comprarItem(context, it: it);
  }
}
