import 'package:arena_x/core/enum/box_cache_keys.dart';
import 'package:arena_x/core/enum/cache_keys.dart';
import 'package:arena_x/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    final Box appBox = Hive.box(BoxCacheKeys.app.id);
    await appBox.put(CacheKeys.lightMode.key, !_darkMode);
    notifyListeners();
  }

  /// Carrega a preferência de tema salvo no cache ou usa o tema atual do sistema
  Future<void> getThemeMode() async {
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

  /// Obtém a cor primária salva no cache ou usa a cor padrão
  Future<void> getThemeColor() async {
    final Box appBox = Hive.box(BoxCacheKeys.app.id);
    final int? colorValue = appBox.get(CacheKeys.primaryColor.key);
    if (colorValue != null) {
      // Procura na lista de cores disponíveis
      final found = materialColors.firstWhere(
        (mc) => mc.value == colorValue,
        orElse: () => Colors.purple,
      );
      _primaryColor = found;
    }
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
    await Hive.openBox(BoxCacheKeys.app.id);
    final Box appBox = Hive.box(BoxCacheKeys.app.id);
    await appBox.put(CacheKeys.primaryColor.key, _primaryColor.value);
    appBox.close();
  }
}
