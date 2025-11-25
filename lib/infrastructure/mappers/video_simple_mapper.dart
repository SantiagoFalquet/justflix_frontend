import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/utils/url_formatter.dart';

class VideoSimpleMapper {
  /// Convierte un mapa JSON a una entidad [VideoSimple].
  /// 
  /// [param] json. El mapa de donde se extraerán los datos.
  /// [returns] Instancia de [VideoSimple]
  static VideoSimple fromJson(Map<String, dynamic> json) {
    /// Validaciones
    final id = json["id"] as String?;
    if (id == null) {
      throw const FormatException(
        "El campo 'id' es requerido y no puede ser nulo.",
      );
    }

    final thumbnail = UrlFormatter.formatPath(json["thumbnail"] as String?);

    return VideoSimple(
      id: id,
      thumbnail: thumbnail,
      duration: (json["duration"] as num?)?.toDouble(),
      );
  }
}
