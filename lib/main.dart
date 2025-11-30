import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:justflix_frontend/app.dart';

/// Entrada principal de la aplicación.
/// 
/// Su función principal es
///   Cargar las variables de entorno antes de iniciar la app Flutter
/// Una vez cargadas, se ejecuta el widget raiz `MyApp`
/// 
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  
  runApp(const MyApp());
}
