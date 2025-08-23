import 'package:hive/hive.dart';

extension HiveExtension on Box {
  /// Obtém um valor `booleano` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  ///
  /// ```dart
  /// bool? isLightMode = await HiveExtension.getBool(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.lightMode.boxKey,
  /// );
  /// ```
  static Future<bool> getBool({
    required String boxName,
    required String key,
    required bool defaultValue,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor booleano associado à chave
    final bool value = myBox.get(key, defaultValue: defaultValue);
    // Retorna o valor booleano obtido
    return value;
  }

  /// Obtém um valor `booleano` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  ///
  /// ```dart
  /// bool? isLightMode = await HiveExtension.getBool(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.lightMode.boxKey,
  /// );
  /// ```
  static Future<bool?> getBoolNullable({
    required String boxName,
    required String key,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor booleano associado à chave
    final bool? value = myBox.get(key);
    // Retorna o valor booleano obtido
    return value;
  }

  /// Abre uma caixa Hive com o nome especificado e coloca um valor `booleano` associado a uma chave.
  /// Fecha a caixa após a operação.
  ///
  /// ```dart
  /// await HiveExtension.putBool(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.lightMode.boxKey,
  ///   value: true,
  /// );
  /// ```
  static Future<void> putBool({
    required String boxName,
    required String key,
    required bool value,
  }) async {
    // Obtém a caixa aberta e coloca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Coloca o valor booleano na caixa
    await myBox.put(key, value);
  }

  /// Obtém um valor `int` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  /// ```dart
  /// int? primaryColorValue = await HiveExtension.getInt(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.primaryColor.boxKey,
  /// );
  /// ```
  static Future<int> getInt({
    required String boxName,
    required String key,
    required int defaultValue,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor inteiro associado à chave
    final int value = myBox.get(key, defaultValue: defaultValue);
    // Retorna o valor inteiro obtido
    return value;
  }

  /// Obtém um valor `int` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  /// ```dart
  /// int? primaryColorValue = await HiveExtension.getInt(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.primaryColor.boxKey,
  /// );
  /// ```
  static Future<int?> getIntNullable({
    required String boxName,
    required String key,
    int? defaultValue,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor inteiro associado à chave
    final int? value = myBox.get(key, defaultValue: defaultValue);
    // Retorna o valor inteiro obtido
    return value;
  }

  /// Abre uma caixa Hive com o nome especificado e coloca um valor `int` associado a uma chave.
  /// Fecha a caixa após a operação.
  /// ```dart
  /// await HiveExtension.putInt(
  ///   boxName: SettingsBox.id.boxName,
  ///   key: SettingsBox.primaryColor.boxKey,
  ///   value: Colors.blue.value,
  /// );
  /// ```
  static Future<void> putInt({
    required String boxName,
    required String key,
    required int value,
  }) async {
    // Obtém a caixa aberta e coloca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Coloca o valor inteiro na caixa
    await myBox.put(key, value);
  }

  /// Obtém uma `String` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  ///
  /// ```dart
  /// String playerName = await HiveExtension.getString(
  ///   boxName: PlayerBox.jogador.boxName,
  ///   key: PlayerBox.jogador.boxKey,
  ///   defaultValue: 'Jogador',
  /// );
  /// ```
  static Future<String> getString({
    required String boxName,
    required String key,
    required String defaultValue,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor da string associada à chave ou o valor padrão se não existir
    final String value = myBox.get(key, defaultValue: defaultValue);
    // Retorna o valor da string obtido
    return value;
  }

  /// Obtém uma `String?` de uma caixa Hive com o nome e chave especificados.
  /// Fecha a caixa após a operação.
  ///
  /// ```dart
  /// String? playerName = await HiveExtension.getString(
  ///   boxName: PlayerBox.jogador.boxName,
  ///   key: PlayerBox.jogador.boxKey,
  ///   defaultValue: 'Jogador',
  /// );
  /// ```
  static Future<String?> getStringNullable({
    required String boxName,
    required String key,
  }) async {
    // Obtém a caixa aberta e busca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Retorna o valor da string associada à chave ou o valor padrão se não existir
    final String? value = myBox.get(key);
    // Retorna o valor da string obtido
    return value;
  }

  /// Abre uma caixa Hive com o nome especificado e coloca um valor `String` associado a uma chave.
  /// Fecha a caixa após a operação.
  /// ```dart
  /// await HiveExtension.putString(
  ///   boxName: PlayerBox.jogador.boxName,
  ///   key: PlayerBox.jogador.boxKey,
  ///   value: 'Jogador',
  /// );
  /// ```
  static Future<void> putString({
    required String boxName,
    required String key,
    required String value,
  }) async {
    // Obtém a caixa aberta e coloca o valor associado à chave
    final Box myBox = Hive.box(boxName);
    // Coloca a string na caixa
    await myBox.put(key, value);
  }
}
