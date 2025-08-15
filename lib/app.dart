import 'package:arena_x/app/home_read.dart';
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
      ],
      child: MaterialApp(
        title: 'EPIC-like RPG',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const HomeRead(),
      ),
    );
  }
}
