import 'package:arena_x/core/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/base/wd_switch_theme.dart';

class SettingRead extends StatelessWidget {
  const SettingRead({super.key});

  @override
  Widget build(BuildContext context) {
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            g.player.name.isNotEmpty ? g.player.name[0].toUpperCase() : 'A',
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 8.0,
              children: [
                WdSwitchTheme(),
                TextFormField(
                  controller: g.playerNameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do jogador',
                    hintText: 'Digite o nome do jogador',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
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
                          content: Text(
                            'O nome do jogador não pode ser vazio!',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
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
