import 'package:arena_x/core/extension/material_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';

class WdColorTheme extends StatelessWidget {
  const WdColorTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState a = context.watch<AppState>();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Cor do tema do aplicativo'),
      subtitle: Text('Selecione a cor principal do tema do aplicativo'),
      trailing: CircleAvatar(
        backgroundColor: a.primaryColor,
        child: Icon(Icons.color_lens, color: a.primaryColor.textColor),
      ),
      onTap: () => _dialogColorPicker(context, a),
    );
  }
}

Future _dialogColorPicker(BuildContext context, AppState a) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('Selecione uma cor'),
        content: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: a.materialColors.map((color) {
            return InkWell(
              onTap: () {
                a.changePrimaryColor(color);
                Navigator.of(dialogContext).pop();
              },
              child: CircleAvatar(
                backgroundColor: color,
                child: Visibility(
                  visible: a.primaryColor == color,
                  child: Icon(Icons.check, color: color.textColor),
                ),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Voltar'),
          ),
        ],
      );
    },
  ).whenComplete(() => a.setPrimaryColor());
}
