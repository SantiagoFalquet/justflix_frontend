import 'package:justflix_frontend/domain/entities/video_simple.dart';

class VideoSimpleMapper {
  static const String _backendBaseUrl = 'http://localhost:3002';
  // Mètode estàtic que rep un JSON i retorna una istància de VideoSimple
  static VideoSimple fromJson(Map<String, dynamic> json) {
    /// Validaciones
    final id = json["id"] as String?;
    if (id == null) {
      throw const FormatException(
        "El campo 'id' es requerido y no puede ser nulo.",
      );
    }

    /// Gestiona url completa o ruta relativa enviada desde el backend.
    var thumbnailPath = json["thumbnail"] as String?;
    if (thumbnailPath != null && !thumbnailPath.startsWith('http')) {
      thumbnailPath = '$_backendBaseUrl/$thumbnailPath';
    }
    final thumbnail = thumbnailPath?.replaceAll('localhost', '10.0.2.2');

    return VideoSimple(id: id, thumbnail: thumbnail);
  }
}
