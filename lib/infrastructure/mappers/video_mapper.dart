import 'package:justflix_frontend/domain/entities/video.dart';

class VideoMapper {
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

    return Video(
      id: id,
      topic: topic,
      description: json["description"] as String?,
      duration: (json["duration"] as num?)?.toDouble(),
      thumbnail: json["thumbnail"] as String?,
    );
  }
}
