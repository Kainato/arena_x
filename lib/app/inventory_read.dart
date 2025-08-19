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
    final GameState game = context.read<GameState>();
    final bool isConsumable = item.type == ItemType.consumable;
    final bool isWeaponEquipped =
        (item.type == ItemType.weapon && game.player.equippedWeapon == item);
    final bool isArmorEquipped =
        (item.type == ItemType.armor && game.player.equippedArmor == item);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: (isConsumable || isWeaponEquipped || isArmorEquipped)
            ? Colors.green
            : null,
      ),
      child: Text(
        isConsumable
            ? 'Usar'
            : (isWeaponEquipped || isArmorEquipped)
            ? 'Equipado'
            : 'Equipar',
        style: TextStyle(
          color: isWeaponEquipped || isArmorEquipped ? Colors.white : null,
        ),
      ),
      onPressed: () {
        if (isWeaponEquipped || isArmorEquipped) {
          game.unequip(context, item: item);
        } else {
          game.equip(item);
        }
      },
    );
  }
}
