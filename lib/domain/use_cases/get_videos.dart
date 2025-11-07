import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';

/// Caso de uso para obtener una lista de videos simples
///
/// Esta clase encapsula la lógica de negocio para recuperar videos
/// utilizando el repositorio de videos.
class GetVideos {
  final VideosRepository repository;
  
  /// Constructor
  GetVideos(this.repository);
  
  /// Ejecuta el caso de uso para obtener videos.
  Future<List<VideoSimple>> call({String searchQuery = ''}) async {
    return await repository.getVideos(searchQuery);
  }
}
