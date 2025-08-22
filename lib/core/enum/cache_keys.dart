/// Esse arquivo define uma enumeração para as chaves de cache usadas no aplicativo.
enum CacheKeys {
  jogador,
  nivel,
  xp,
  ouro,
  inventario,
  lightMode,
  primaryColor,
}

extension CacheKeysExtension on CacheKeys {
  /// Retorna a chave de cache correspondente para cada enumeração.
  /// Isso é usado para armazenar e recuperar valores do cache de forma consistente.
  String get key {
    switch (this) {
      case CacheKeys.jogador:
        return 'Aventureiro';
      case CacheKeys.nivel:
        return 'nivel';
      case CacheKeys.xp:
        return 'xp';
      case CacheKeys.ouro:
        return 'ouro';
      case CacheKeys.inventario:
        return 'inventario';
      case CacheKeys.lightMode:
        return 'lightMode';
      case CacheKeys.primaryColor:
        return 'primaryColor';
    }
  }
}