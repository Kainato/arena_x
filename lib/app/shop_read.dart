import 'package:arena_x/utils/widgets/wd_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/game_state.dart';

class ShopRead extends StatelessWidget {
  const ShopRead({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();
    final catalog = game.loot.getCatalog();

    return WDScaffold(
      title: 'Loja',
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final it = catalog[i];
          return ListTile(
            title: Text(it.name),
            subtitle: Text(
              'ATK +${it.attack} DEF +${it.defense} Cura +${it.heal}',
            ),
            trailing: ElevatedButton(
              onPressed: game.player.gold >= it.price
                  ? () {
                      game.player.gold -= it.price;
                      game.player.inventory.add(it);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Comprado: ${it.name}!')),
                      );
                      game.notifyListeners();
                    }
                  : null,
              child: Text('Comprar (${it.price})'),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: catalog.length,
      ),
    );
  }
}
