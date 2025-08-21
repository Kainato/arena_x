import 'package:arena_x/core/state/app_state.dart';
import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingRead extends StatelessWidget {
  const SettingRead({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState a = context.watch<AppState>();
    final GameState g = context.watch<GameState>();
    // final List<MaterialColor> materialColors = [
    //   Colors.red,
    //   Colors.green,
    //   Colors.blue,
    //   Colors.yellow,
    //   Colors.orange,
    //   Colors.purple,
    //   Colors.teal,
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(a.themeName),
          value: a.isDarkMode,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          onChanged: (value) {
            a.toggleTheme();
          },
        ),
        Divider(),
        TextFormField(
          controller: g.playerNameController,
          decoration: InputDecoration(
            labelText: 'Nome do jogador',
            hintText: 'Digite o nome do jogador',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              g.setPlayerName(value);
            } else {
              g.getPlayerName();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('O nome do jogador não pode ser vazio!'),
                ),
              );
            }
          },
        ),
        // BlockPicker(
        //   pickerColor: a.primaryColor,
        //   availableColors: [
        //     Colors.red,
        //     Colors.green,
        //     Colors.blue,
        //     Colors.yellow,
        //     Colors.orange,
        //     Colors.purple,
        //     Colors.teal,
        //   ],
        //   onColorChanged: (Color color) {
        //     // Converta Color para MaterialColor
        //     final materialColor = materialColors.firstWhere(
        //       (mc) => mc == color,
        //       orElse: () => Colors.teal,
        //     );
        //     a.setPrimaryColor(materialColor);
        //   },
        // ),
      ],
    );
  }
}
