import 'package:arena_x/core/box/settings_box.dart';
import 'package:arena_x/core/extension/hive_extension.dart';
import 'package:arena_x/core/extension/material_color_extension.dart';
import 'package:arena_x/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  /// Inicializa o estado do aplicativo e carrega as preferências salvas
  AppState() {
    getThemeMode();
    getThemeColor();
  }

  /// Variável para controlar o modo de tema (claro/escuro)
  bool _darkMode = false;

  /// Getter para verificar se o modo escuro está ativo
  bool get darkMode => _darkMode;

  /// Retorna o modo de tema atual e sua descrição
  (ThemeMode, String) get themeMode => _darkMode
      ? (ThemeMode.dark, 'Modo Escuro')
      : (ThemeMode.light, 'Modo Claro');

  /// Alterna entre o modo claro e escuro, salvando a preferência no cache
  Future<void> toggleTheme() async {
    _darkMode = !_darkMode;
    await HiveExtension.putBool(
      boxName: SettingsBox.id.boxName,
      key: SettingsBox.darkMode.boxKey,
      value: _darkMode,
    );
    notifyListeners();
  }

  /// Carrega a preferência de tema salvo no cache ou usa o tema atual do sistema
  Future<void> getThemeMode() async {
    bool? darkModeFromCache = await HiveExtension.getBoolNullable(
      boxName: SettingsBox.id.boxName,
      key: SettingsBox.darkMode.boxKey,
    );
    if (darkModeFromCache != null) {
      _darkMode = darkModeFromCache;
    } else {
      Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        _darkMode = true;
      } else {
        _darkMode = false;
      }
    }
    notifyListeners();
  }

  /// Obtém a cor primária salva no cache ou usa a cor padrão
  Future<void> getThemeColor() async {
    final int colorValue = await HiveExtension.getInt(
      boxName: SettingsBox.id.boxName,
      key: SettingsBox.primaryColor.boxKey,
      defaultValue: Colors.purple.toInt,
    );
    // Procura na lista de cores disponíveis
    final MaterialColor found = materialColors.firstWhere(
      (mc) => mc.toInt == colorValue,
    );
    _primaryColor = found;
    notifyListeners();
  }

  MaterialColor _primaryColor = Colors.purple;

  MaterialColor get primaryColor => _primaryColor;

  List<MaterialColor> get materialColors => AppTheme(this).materialColors;

  void changePrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }

  Future<void> setPrimaryColor() async {
    await HiveExtension.putInt(
      boxName: SettingsBox.id.boxName,
      key: SettingsBox.primaryColor.boxKey,
      value: _primaryColor.toInt,
    );
  }
}
