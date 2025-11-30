import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';

/// Un repositorio es una abstracción de la capa de datos.
/// 
/// Define un contrato (una interfaz) que la capa de dominio utiliza para
/// acceder a los datos, sin saber de dónde viene (API, base detos, etc.).
abstract class VideosRepository {
  /// Obtiene una lista de vídeos simplificados para una búsqueda.
  Future<List<VideoSimple>> getVideos(String video);

  /// Obtiene la información completa de un vídeo específico usan su ID.
  Future<Video?> getVideoById(String videoId);
}
