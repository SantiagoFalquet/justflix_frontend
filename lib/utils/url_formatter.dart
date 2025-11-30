import 'package:justflix_frontend/infrastructure/config/app_config.dart';

class UrlFormatter {
  /// Formatea una URL de imagen o video, añadiendo la URL base del backend
  /// si es una ruta relativa y ajustando 'localhost' para emuladores Android.
  ///
  /// [path] La ruta de la imagen o video, que puede ser una URL completa
  /// o una ruta relativa.
  /// [returns] La URL formateada y completa.
  static String? formatPath(String? path) {
    if (path == null) {
      return null;
    }

    String formattedPath = path;

    // Si es una ruta relativa, construimos la URL completa.
    if (!formattedPath.startsWith('http')) {
      formattedPath = '${AppConfig.backendBaseUrl}/$formattedPath';
    }

    // Reemplazar 'localhost' por '10.0.2.2' para compatibilidad con emuladores Android
    return formattedPath.replaceAll('localhost', '10.0.2.2');
  }
}
