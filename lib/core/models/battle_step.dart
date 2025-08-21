class BattleStep {
  final int playerHealth;
  final int monsterHealth;
  final String action;
  final String message;
  final int? dice;
  final bool myTurn;

  BattleStep({
    required this.playerHealth,
    required this.monsterHealth,
    required this.action,
    required this.message,
    this.dice,
    required this.myTurn,
  });

  @override
  String toString() {
    return 'Action: $action, Player Health: $playerHealth, Monster Health: $monsterHealth, Message: $message (Dice: $dice, My Turn: $myTurn)';
  }
}
