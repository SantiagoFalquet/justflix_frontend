import 'package:justflix_frontend/domain/entities/video_simple.dart';

class VideoSimpleMapper {
  // Mètode estàtic que rep un JSON i retorna una istància de VideoSimple
  static VideoSimple fromJson(Map<String, dynamic> json) {
    /// Validaciones
    final id = json["id"] as String?;
    if (id == null) {
      throw const FormatException(
        "El campo 'id' es requerido y no puede ser nulo.",
      );
    }

    return VideoSimple(
      id: id,
      thumbnail: json["thumbnail"] as String?,
      );
  }
}
