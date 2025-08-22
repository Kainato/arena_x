import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';

class WdSwitchTheme extends StatelessWidget {
  const WdSwitchTheme({super.key});

  @override
  Widget build(BuildContext context) {
    /// Obtém, pelo provider, o estado do aplicativo
    final AppState a = context.watch<AppState>();

    return SwitchListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'Tema do aplicativo',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text('Atual: ${a.themeMode.$2}'),
      value: a.darkMode,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(12.0),
      ),
      isThreeLine: true,
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
        if (a.darkMode) {
          return const Icon(Icons.nightlight_round);
        } else {
          return const Icon(Icons.wb_sunny);
        }
      }),
      onChanged: (value) => a.toggleTheme(),
    );
  }
}
