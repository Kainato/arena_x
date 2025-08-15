import 'package:arena_x/core/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingRead extends StatelessWidget {
  const SettingRead({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState a = context.watch<AppState>();
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
          onChanged: (value) {
            a.toggleTheme();
          },
        ),
        Divider(),
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
