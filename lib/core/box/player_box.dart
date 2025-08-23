enum PlayerBox { id, jogador, nivel, xp, ouro, inventario }

extension PlayerBoxExtension on PlayerBox {
  String get boxName {
    switch (this) {
      case PlayerBox.id:
        return 'playerBox';
      default:
        return '';
    }
  }

  String get boxKey {
    switch (this) {
      case PlayerBox.jogador:
        return 'jogador';
      case PlayerBox.nivel:
        return 'nivel';
      case PlayerBox.xp:
        return 'xp';
      case PlayerBox.ouro:
        return 'ouro';
      case PlayerBox.inventario:
        return 'inventario';
      default:
        return '';
    }
  }
}
