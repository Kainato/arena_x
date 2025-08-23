import 'package:arena_x/app.dart';
import 'package:arena_x/core/box/player_box.dart';
import 'package:arena_x/core/box/settings_box.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  /// Inicializa o Flutter antes de carregar SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializa o Hive
  await Hive.openBox(SettingsBox.id.boxName);
  await Hive.openBox(PlayerBox.id.boxName);

  runApp(const MainApp());
}
