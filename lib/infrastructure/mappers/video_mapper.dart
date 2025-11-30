import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/utils/url_formatter.dart';

class VideoMapper {
  // Mètode estàtic que rep un JSON i retorna una instància de Video (entidad de dominio)
  static Video fromJson(Map<String, dynamic> json) {
    /// Asegurar que los campos requerido no sean nulos y tengan un tipo correcto.
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

    final thumbnail = UrlFormatter.formatPath(json["thumbnail"] as String?);
    final videoUrl = UrlFormatter.formatPath(json["videoUrl"] as String?);

    // Instancia de Video
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
