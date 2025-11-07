import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';

class VideosProvider extends ChangeNotifier {
  final VideosRepository videosRepository;

  VideosProvider({required this.videosRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<VideoSimple> _videos = [];
  List<VideoSimple> get videos => _videos;

  String? _error;
  String? get error => _error;

  Future<void> loadVideos({String searchQuery = ''}) async {_isLoading = true;notifyListeners();

    _videos = await videosRepository.getVideos(searchQuery);

    _isLoading = false;
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
}
