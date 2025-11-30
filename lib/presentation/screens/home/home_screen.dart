import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/repo_singleton.dart';
import 'package:justflix_frontend/assets.dart';
import 'package:justflix_frontend/presentation/widgets/shared/empty_state_widget.dart';
import 'package:justflix_frontend/presentation/widgets/shared/error_state_widget.dart';
import 'package:justflix_frontend/presentation/widgets/shared/loading_indicator_widget.dart';
import 'package:justflix_frontend/presentation/screens/home/sections/responsive_video_layout.dart';

/// Pantalla principal que muestra una lista de videos y su detalle de forma responsiva.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _videosRepository = RepoSingleton().repository;

  bool _isLoading = true;
  String? _error;
  List<VideoSimple> _videos = [];

  Video? _selectedVideo;
  bool _isLoadingDetail = false;
  String? _detailError;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  /// Carga la lista inicial de videos desde el repositorio.
  Future<void> _loadVideos() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final fetchedVideos = await _videosRepository.getVideos('');
      setState(() {
        _videos = fetchedVideos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar los videos: $e';
        _isLoading = false;
      });
    }
  }

  /// Carga el detalle de un video por su ID.
  Future<void> _handleVideoSelected(String videoId) async {
    setState(() {
      _isLoadingDetail = true;
      _detailError = null;
      _selectedVideo = null; // Limpia el video anterior
    });

    try {
      final fetchedVideo = await _videosRepository.getVideoById(videoId);
      setState(() {
        _selectedVideo = fetchedVideo;
        _isLoadingDetail = false;
      });
    }
    catch (e) {
      setState(() {
        _detailError = 'Error al cargar el detalle del video: $e';
        _isLoadingDetail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.images.logo, height: 40),
      ),
      body: _buildBody(),
    );
  }

  /// Construye el cuerpo de la pantalla basándose en el estado local.
  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicatorWidget();
    }

    if (_error != null) {
      return ErrorStateWidget(
        message: _error!,
        onRetry: _loadVideos,
      );
    }

    if (_videos.isEmpty) {
      return EmptyStateWidget(
        message: 'No se encontraron videos.',
        onRetry: _loadVideos,
      );
    }

    return ResponsiveVideoLayout(
      videos: _videos,
      onVideoSelected: _handleVideoSelected,
      selectedVideo: _selectedVideo,
      isLoadingDetail: _isLoadingDetail,
      detailError: _detailError,
    );
  }
}
