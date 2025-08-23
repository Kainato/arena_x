import 'package:arena_x/app/home/home_read.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/state/game_state.dart';

class Redirect extends StatefulWidget {
  const Redirect({super.key});

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      // ignore: use_build_context_synchronously
      Future.microtask(() => context.read<GameState>().bootstrap());
      _started = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GameState g = context.watch<GameState>();
    return Builder(
      builder: (BuildContext context) {
        if (g.isLoadingGame) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const HomeRead();
        }
      },
    );
  }
}
