import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _themeIsDark = false;

  bool get isDarkMode => _themeIsDark;

  String get themeName {
    return _themeIsDark ? 'Modo Escuro' : 'Modo Claro';
  }

  ThemeMode get themeMode {
    return _themeIsDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _themeIsDark = !_themeIsDark;
    notifyListeners();
  }

  void getTheme() {
    ThemeMode mode =
        defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android
        ? ThemeMode.system
        : ThemeMode.light;
    if (mode == ThemeMode.dark) {
      _themeIsDark = true;
    } else {
      Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        _themeIsDark = true;
      } else {
        _themeIsDark = false;
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
