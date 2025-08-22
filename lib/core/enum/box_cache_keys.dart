enum BoxCacheKeys {
  app,
  player
}

extension BoxCacheKeysExtension on BoxCacheKeys {
  String get id {
    switch (this) {
      case BoxCacheKeys.app:
        return 'app';
      case BoxCacheKeys.player:
        return 'player';
    }
  }
}