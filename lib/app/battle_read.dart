import 'package:flutter/material.dart';

class BattleRead extends StatelessWidget {
  final List<String> log;
  const BattleRead({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Batalha')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) => Text('• ${log[i]}'),
        separatorBuilder: (_, __) => const Divider(height: 16),
        itemCount: log.length,
      ),
    );
  }
}
