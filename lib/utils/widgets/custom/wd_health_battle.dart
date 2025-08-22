import 'package:flutter/material.dart';

class WdHealthBattle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int actualHealth;
  final int maxHealth;
  final Color color;

  const WdHealthBattle({
    super.key,
    required this.title,
    this.subtitle,
    required this.actualHealth,
    required this.maxHealth,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    int actualHealthClamped = actualHealth.clamp(0, maxHealth);
    return Card(
      elevation: 0,
      color: Colors.grey[200],
      child: ListTile(
        title: _buildTitle(title: title, subtitle: subtitle),
        subtitle: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHealthBar(
              actualHealthClamped: actualHealthClamped,
              maxHealth: maxHealth,
              color: color,
            ),
            _buildHealthText(actual: actualHealthClamped, max: maxHealth),
          ],
        ),
      ),
    );
  }
}

/// Constrói o título da barra de saúde
/// com o nome do personagem e, opcionalmente, um subtítulo a direita
Row _buildTitle({required String title, String? subtitle}) {
  return Row(
    spacing: 16,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      if (subtitle != null)
        Text(subtitle, style: const TextStyle(fontStyle: FontStyle.italic)),
    ],
  );
}

/// Constrói a barra de saúde com um círculo contendo um ícone
/// e o texto de saúde atual/max
Widget _buildHealthBar({
  required int actualHealthClamped,
  required int maxHealth,
  required Color color,
}) {
  return Expanded(
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Barra de saúde
        Container(
          height: 16,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(left: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 1.0,
                end: actualHealthClamped / maxHealth,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: color.withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 16,
                );
              },
            ),
          ),
        ),
        // Círculo com ícone
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.white,
          ),
          child: Center(child: Icon(Icons.favorite, color: color, size: 20)),
        ),
      ],
    ),
  );
}

/// Constrói o texto de saúde atual/max com estilo itálico
Text _buildHealthText({required int actual, required int max}) {
  return Text('$actual/$max', style: const TextStyle(fontStyle: FontStyle.italic));
}
