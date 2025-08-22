import 'package:arena_x/app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'core/enum/box_cache_keys.dart';

Future<void> main() async {
  /// Inicializa o Flutter antes de carregar SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  /// Abre o Hive e registra os adaptadores necessários
  await Hive.openBox(BoxCacheKeys.app.id);
  await Hive.openBox(BoxCacheKeys.player.id);

  runApp(const MainApp());
}
