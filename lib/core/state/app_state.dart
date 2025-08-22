import 'package:arena_x/core/enum/cache_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  /// Inicializa o estado do aplicativo e carrega as preferências salvas
  AppState() {
    getTheme();
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
  void toggleTheme() async {
    _darkMode = !_darkMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CacheKeys.lightMode.key, !_darkMode);
    notifyListeners();
  }

  /// Carrega a preferência de tema salvo no cache ou usa o tema atual do sistema
  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? mode = prefs.getBool(CacheKeys.lightMode.key);
    if (mode != null) {
      if (mode) {
        _darkMode = false;
      } else {
        _darkMode = true;
      }
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

  MaterialColor _primaryColor = Colors.teal;

  MaterialColor get primaryColor => _primaryColor;

  void setPrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }
}
