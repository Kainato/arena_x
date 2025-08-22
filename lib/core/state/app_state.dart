import 'package:arena_x/core/enum/box_cache_keys.dart';
import 'package:arena_x/core/enum/cache_keys.dart';
import 'package:arena_x/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  Future<void> toggleTheme() async {
    _darkMode = !_darkMode;
    final Box appBox = Hive.box(BoxCacheKeys.app.id);
    await appBox.put(CacheKeys.lightMode.key, !_darkMode);
    notifyListeners();
  }

  /// Carrega a preferência de tema salvo no cache ou usa o tema atual do sistema
  Future<void> getTheme() async {
    final Box appBox = Hive.box(BoxCacheKeys.app.id);
    bool? mode = appBox.get(CacheKeys.lightMode.key);
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

  MaterialColor _primaryColor = Colors.purple;

  MaterialColor get primaryColor => _primaryColor;

  List<MaterialColor> get materialColors => AppTheme(this).materialColors;

  void setPrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }
}
