import 'package:arena_x/app/setting_read.dart';
import 'package:arena_x/app/shop_read.dart';
import 'package:arena_x/app/status_read.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/game_state.dart';
import '../utils/widgets/wd_scaffold.dart';

class HomeRead extends StatelessWidget {
  const HomeRead({super.key});

  @override
  Widget build(BuildContext context) {
    final GameState game = context.watch<GameState>();

    return WdScaffold.bottomNavigation(
      title: 'EPIC-like RPG',
      currentIndex: game.indexTab,
      onTap: (i) => game.setIndex(i),
      body: [const StatusRead(), const ShopRead(), SettingRead()],
      bottomNavigationBar: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: const Icon(Icons.store), label: 'Loja'),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }
}
