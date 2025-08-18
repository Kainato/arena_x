/// Esse arquivo define uma enumeração para as chaves de cache usadas no aplicativo.
enum CacheKeys {
  nome,
  nivel,
  xp,
  ouro,
  inventario,
}

extension CacheKeysExtension on CacheKeys {
  /// Retorna a chave de cache correspondente para cada enumeração.
  /// Isso é usado para armazenar e recuperar valores do cache de forma consistente.
  String get key {
    switch (this) {
      case CacheKeys.nome:
        return 'Aventureiro';
      case CacheKeys.nivel:
        return 'nivel';
      case CacheKeys.xp:
        return 'xp';
      case CacheKeys.ouro:
        return 'ouro';
      case CacheKeys.inventario:
        return 'inventario';
    }
  }

  /// Retorna uma descrição legível para cada chave de cache.
  /// Isso pode ser útil para depuração ou exibição ao usuário.
  String get description {
    switch (this) {
      case CacheKeys.nome:
        return 'Nome do jogador';
      case CacheKeys.nivel:
        return 'Nível do jogador';
      case CacheKeys.xp:
        return 'Experiência do jogador';
      case CacheKeys.ouro:
        return 'Ouro acumulado pelo jogador';
      case CacheKeys.inventario:
        return 'Itens no inventário do jogador';
    }
  }
}