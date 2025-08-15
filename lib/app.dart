import 'package:arena_x/app/home_read.dart';
import 'package:arena_x/core/state/app_state.dart';
import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameState()..bootstrap()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'EPIC-like RPG',
            theme: ThemeData(
              primarySwatch: appState.primaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: appState.primaryColor,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: appState.themeMode,
            home: const HomeRead(),
          );
        },
      ),
    );
  }
}
