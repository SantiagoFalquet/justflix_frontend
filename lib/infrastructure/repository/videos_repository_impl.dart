// Part d'infrastructura del repositori
// Implementa les funcionalitats de la classe abstracta VideosRepository
// Cal notar que a Dart no existeixen intefaces com a tal, però totes les
// classes poden actuar com a interfaces.
// La forma de definir una interface és declarant una classe abstracta
// i implementant els mètodes d'aquesta.

import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';
import 'package:justflix_frontend/infrastructure/data_sources/videos_api.dart';
import 'package:justflix_frontend/infrastructure/mappers/video_mapper.dart';
import 'package:justflix_frontend/infrastructure/mappers/video_simple_mapper.dart';

class VideosRepositoryImpl implements VideosRepository {
  // Referència a l'API remota
  final VideosApi remote;
  // L'API s'inicialitza en el constructor
  VideosRepositoryImpl(this.remote);

  // Obtiene una lista de videos del servidor
  @override
  Future<List<VideoSimple>> getVideos(String searchQuery) async {
    try {
      // Await esperando a la respuesta
      final jsonVideos = await remote.getVideos(searchQuery);
      return jsonVideos
          .map((videosJSON) => VideoSimpleMapper.fromJson(videosJSON))
          .toList();
    } catch (e) {
      print("Error al recuperar lOs videos: $e");
      return [];
    }
  }

  // Obtiene información detallada del video por su id
  @override
  Future<Video?> getVideoById(String videoId) async {
    try {
      final jsonVideo = await remote.getVideoById(videoId);
      return VideoMapper.fromJson(jsonVideo);
    } catch (e) {
      print("Error al recuperar la información del video: $e");
      return null;
    }
  }
}
