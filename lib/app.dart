import 'package:arena_x/app/redirect.dart';
import 'package:arena_x/core/state/app_state.dart';
import 'package:arena_x/core/state/game_state.dart';
import 'package:arena_x/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => GameState()),
      ],
      child: Consumer<AppState>(
        builder: (BuildContext context, AppState a, Widget? child) {
          return MaterialApp(
            title: 'EPIC-like RPG',
            theme: AppTheme(a).theme,
            darkTheme: AppTheme(a).theme,
            themeMode: a.themeMode.$1,
            home: Redirect(),
          );
        },
      ),
    );
  }
}
