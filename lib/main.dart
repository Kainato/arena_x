import 'package:arena_x/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  /// Inicializa o Flutter antes de carregar SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  /// Carrega a SharedPreferences antes de iniciar o app
  await SharedPreferences.getInstance();

  /// Inicia o aplicativo principal
  runApp(const MainApp());
}
