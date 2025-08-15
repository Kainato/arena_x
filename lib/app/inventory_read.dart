import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/item.dart';
import '../../core/state/game_state.dart';
import '../core/enum/item_type.dart';

class InventoryRead extends StatelessWidget {
  const InventoryRead({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();
    final List<Item> items = game.player.inventory;

    return Builder(
      builder: (context) {
        if (items.isEmpty) {
          return Center(child: Text('Seu inventário está vazio!'));
        }
        return ListView.separated(
          separatorBuilder: (_, __) => const Divider(),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final Item it = items[i];
            return ListTile(
              title: Text(it.name),
              subtitle: Text(
                '${it.type.name.toUpperCase()} • ${it.rarity.name.toUpperCase()}',
              ),
              trailing: _ActionButton(item: it),
            );
          },
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Item item;
  const _ActionButton({required this.item});

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameState>();
    final isConsumable = item.type == ItemType.consumable;
    return ElevatedButton(
      onPressed: () {
        game.equip(item);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isConsumable ? 'Consumido!' : 'Equipado!')),
        );
      },
      child: Text(isConsumable ? 'Usar' : 'Equipar'),
    );
  }
}
