import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';

/// Caso de uso para obtener la informaicón
/// detallada de un video por su ID.
///
/// Esta clase encapsula la lógica de negocio para recuperar videos
/// específico utilizando el repositorio de videos.
class GetVideosById {
  final VideosRepository repository;
  
  /// Constructor que inyecta la dependencia del repositorio de vídeos.
  GetVideosById(this.repository);
  
  /// Ejecuta el caso de uso para obtener video por su ID.
  Future<Video?> call(String videoId) async {
    return await repository.getVideoById(videoId);
  }
}
