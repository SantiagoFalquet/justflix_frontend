import 'package:flutter/material.dart';
import 'package:justflix_frontend/infrastructure/repository/videos_repository_impl.dart';
import 'package:justflix_frontend/assets.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/widgets/shared/empty_state_widget.dart';
import 'package:justflix_frontend/presentation/widgets/shared/error_state_widget.dart';
import 'package:justflix_frontend/presentation/widgets/shared/loading_indicator_widget.dart';
import 'package:justflix_frontend/presentation/screens/home/sections/responsive_video_layout.dart';

/// Pantalla principal que muestra una lista de videos y su detalle de forma responsiva.
///
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required VideosRepositoryImpl repository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carga los videos cuando la pantalla se inicializa.
    Provider.of<VideosProvider>(context, listen: false).loadVideos();
  }

  /// Maneja la selección de un video de la lista.
  /// Carga el detalle completo del video usando el provider.
  void _handleVideoSelected(String videoId) {
    Provider.of<VideosProvider>(context, listen: false).loadVideoById(videoId);
  }

  @override
  Widget build(BuildContext context) {
    // Observa los cambios en VideosProvider para reconstruir la UI.
    final videosProvider = context.watch<VideosProvider>();

    return Scaffold(
      appBar: AppBar(
        /// Mostra el logo de la aplicación en el AppBar.
        title: Image.asset(AppAssets.images.logo, height: 40),
      ),
      body: _buildBody(videosProvider),
    );
  }

  /// Construye el cuerpo de la pantalla basándose en el estado del provider.
  Widget _buildBody(VideosProvider videosProvider) {
    if (videosProvider.isLoading) {
      return const LoadingIndicatorWidget();
    }

    if (videosProvider.error != null) {
      return ErrorStateWidget(
        message: videosProvider.error!,
        onRetry: videosProvider.loadVideos,
      );
    }

    if (videosProvider.videos.isEmpty) {
      return EmptyStateWidget(
        message: 'No se encontraron videos.',
        onRetry: videosProvider.loadVideos,
      );
    }

    return ResponsiveVideoLayout(
      videos: videosProvider.videos,
      onVideoSelected: _handleVideoSelected,
    );
  }
}
