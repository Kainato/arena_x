import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WdAppbar extends StatelessWidget implements PreferredSizeWidget {
  const WdAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    GameState game = context.watch<GameState>();
    return AppBar(
      centerTitle: false,
      title: ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            game.player.name[0],
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        title: Text('EPIC-like RPG'),
        subtitle: Text('Olá, ${game.player.name}!'),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
