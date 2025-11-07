import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';

class VideosProvider extends ChangeNotifier {
  final VideosRepository videosRepository;
  
  VideosProvider({
    required this.videosRepository
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<VideoSimple> _videos = [];
  List<VideoSimple> get videos => _videos;

  Future<void> loadVideos({
    String searchQuery =''
  }) async {
    _isLoading = true;
    notifyListeners();

    _videos = await videosRepository.getVideos(searchQuery);

    _isLoading = false;
    notifyListeners();
  }

}