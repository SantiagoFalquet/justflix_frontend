import 'package:justflix_frontend/domain/entities/video.dart';

class VideoMapper {
  static const String _backendBaseUrl = 'http://localhost:3002';
  
  // Mètode estàtic que rep un JSON i retorna una istància de Video
  static Video fromJson(Map<String, dynamic> json) {
    /// Asegurar que los campos requierido no sean nulos y tenga un tipo correcto.
    /// Validaciones de errores.
    final id = json["id"] as String?;
    if (id == null) {
      throw const FormatException(
        "El campo 'id' es requerido y no puede ser nulo.",
      );
    }

    final topic = json["topic"] as String?;
    if (topic == null) {
      throw const FormatException(
        "El campo 'topic' es requerido y no puede ser nulo.",
      );
    }

    /// Gestiona url completa o ruta relativa enviada desde el backend.
    var thumbnailPath = json["thumbnail"] as String?;
    /// Caso de ruta relavita, construimos la URL completa.
    if (thumbnailPath != null && !thumbnailPath.startsWith('http')) {
      thumbnailPath = '$_backendBaseUrl/$thumbnailPath';
    }
    final thumbnail = thumbnailPath?.replaceAll('localhost', '10.0.2.2');
    
    var videoURLPath = json["videoUrl"] as String?;
    if (videoURLPath != null && !videoURLPath.startsWith('http')) {
      videoURLPath = '$_backendBaseUrl/$videoURLPath';
    }
    final videoUrl = videoURLPath?.replaceAll('localhost', '10.0.2.2');

    return Video(
      id: id,
      topic: topic,
      description: json["description"] as String?,
      duration: (json["duration"] as num?)?.toDouble(),
      thumbnail: thumbnail,
      videoUrl: videoUrl,
    );
  }
}
