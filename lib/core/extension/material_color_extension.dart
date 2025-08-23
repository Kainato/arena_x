import 'package:flutter/material.dart';

extension MaterialColorExtension on MaterialColor {
  /// Retorna a cor para um texto de acordo com a luminância da cor selecionada
  Color get textColor => computeLuminance() > 0.5 ? Colors.black : Colors.white;

  /// Retorna o valor inteiro equivalente a cor primária
  int get toInt => shade500.toARGB32();
}
