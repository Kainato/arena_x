import 'package:flutter/material.dart';

import '../state/app_state.dart';

class AppTheme {
  /// Instância do AppState para acessar as preferências do usuário
  final AppState a;

  /// Construtor da classe AppTheme
  AppTheme(this.a);

  /// Retorna o tema claro baseado nas preferências do AppState
  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: a.primaryColor,
      brightness: a.darkMode ? Brightness.dark : Brightness.light,
      cardTheme: CardThemeData(
        // color: a.primaryColor.shade50,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      textTheme: TextTheme(
        // Rótulos e legendas
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        // Texto do corpo
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        // Títulos
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        // Cabeçalhos
        headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        // Textos de destaque
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
