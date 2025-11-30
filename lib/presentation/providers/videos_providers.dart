/* import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';

/// Un provider que gestiona el estado de los videos, tanto la lista principal
/// como el video seleccionado para el detalle.
class VideosProvider extends ChangeNotifier {
  final VideosRepository videosRepository;

  VideosProvider({required this.videosRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Estado para la lista de videos.
  List<VideoSimple> _videos = [];
  List<VideoSimple> get videos => _videos;

  String? _error;
  String? get error => _error;

  /// Estado para el video de detalle.
  bool _isLoadingDetail = false;
  bool get isLoadingDetail => _isLoadingDetail;

  Video? _selectedVideo;
  Video? get selectedVideo => _selectedVideo;

  String? _detailError;
  String? get detailError => _detailError;

  /// Carga la lista de videos simplificados.
  Future<void> loadVideos({String searchQuery = ''}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _videos = await videosRepository.getVideos(searchQuery);
    } catch (e) {
      _error = "Error al cargar los videos: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carga la información completa de un video por su ID.
  Future<void> loadVideoById(String videoId) async {
    _isLoadingDetail = true;
    _detailError = null;
    notifyListeners();

    try {
      _selectedVideo = await videosRepository.getVideoById(videoId);
    } catch (e) {
      _detailError = "Error al cargar el detalle del video: ${e.toString()}";
      _selectedVideo = null; // Limpia el video anterior si hay un error.
    } finally {
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  /// Limpia la selección de video de detalle.
  void clearSelectedVideo(){
    _selectedVideo = null;
    _detailError = null;
    notifyListeners();
  }
}
 */