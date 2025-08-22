import 'package:arena_x/app/home/tab/setting_read.dart';
import 'package:arena_x/app/home/tab/shop_read.dart';
import 'package:arena_x/app/home/tab/status_read.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/game_state.dart';
import '../../core/enum/home_navigation.dart';
import '../../utils/widgets/layout/wd_scaffold.dart';

class HomeRead extends StatelessWidget {
  const HomeRead({super.key});

  @override
  Widget build(BuildContext context) {
    final GameState game = context.watch<GameState>();

    return WdScaffold.bottomNavigation(
      title: 'Arena X - RPG',
      currentIndex: game.indexTab,
      onTap: (i) => game.setIndex(i),
      body: const [StatusRead(), ShopRead(), SettingRead()],
      bottomNavigationBar: [
        BottomNavigationBarItem(
          activeIcon: Icon(HomeNavigation.adventure.activeIcon),
          icon: Icon(HomeNavigation.adventure.icon),
          label: HomeNavigation.adventure.title,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(HomeNavigation.shop.activeIcon),
          icon: Icon(HomeNavigation.shop.icon),
          label: HomeNavigation.shop.title,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(HomeNavigation.settings.activeIcon),
          icon: Icon(HomeNavigation.settings.icon),
          label: HomeNavigation.settings.title,
        ),
      ],
    );
  }
}
