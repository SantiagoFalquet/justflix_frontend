import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Clase que contiene la configuración general de la aplicación
/// 
/// Se encargar de centralizar variables de configuración que puedan variar según el entorno del fichero .env.
/// 
class AppConfig {
  static String backendBaseUrl = dotenv.env['BACKEND_BASE_URL'] ?? 'http://localhost:3000';
  static String apiUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
}
