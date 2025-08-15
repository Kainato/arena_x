import 'package:arena_x/core/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingRead extends StatelessWidget {
  const SettingRead({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState a = context.watch<AppState>();

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
      ],
    );
  }
}
