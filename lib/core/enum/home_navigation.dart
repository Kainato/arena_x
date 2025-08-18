import 'package:flutter/material.dart';

/// Enum que representa as diferentes seções de navegação por todo o aplicativo.
/// Cada valor do enum possui um título e um ícone associado.
enum HomeNavigation { adventure, shop, settings }

extension HomeNavigationExtension on HomeNavigation {
  /// Retorna o título associado a cada valor do enum.
  String get title {
    switch (this) {
      case HomeNavigation.adventure:
        return 'Aventura';
      case HomeNavigation.shop:
        return 'Loja';
      case HomeNavigation.settings:
        return 'Configurações';
    }
  }

  /// Retorna o ícone ativo associado a cada valor do enum.
  /// Utiliza o pacote `Icons` do Flutter para fornecer ícones padrão.
  IconData get icon {
    switch (this) {
      case HomeNavigation.adventure:
        return Icons.explore_outlined;
      case HomeNavigation.shop:
        return Icons.store_outlined;
      case HomeNavigation.settings:
        return Icons.settings_outlined;
    }
  }

  /// Retorna o ícone padrão associado a cada valor do enum.
  /// Utiliza o pacote `Icons` do Flutter para fornecer ícones padrão.
  IconData get activeIcon {
    switch (this) {
      case HomeNavigation.adventure:
        return Icons.explore;
      case HomeNavigation.shop:
        return Icons.store;
      case HomeNavigation.settings:
        return Icons.settings;
    }
  }
}
