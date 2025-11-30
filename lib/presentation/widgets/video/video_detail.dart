import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/presentation/widgets/shared/loading_indicator_widget.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_player_orchestrator.dart';

/// Un widget que muestra el detalle de un video seleccionado.
///
/// Muestra un estado de carga, error o el contenido del video
/// basándose en los parámetros recibidos.
class VideoDetail extends StatelessWidget {
  final Video? video;
  final bool isLoading;
  final String? error;

  const VideoDetail({
    super.key,
    this.video,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingIndicatorWidget();
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    if (video == null) {
      return const Center(
        child: Text('Selecciona un video para ver los detalles'),
      );
    }

    return _VideoDetailContent(video: video!);
  }
}

class _VideoDetailContent extends StatelessWidget {
  final Video video;
  const _VideoDetailContent({required this.video});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (video.videoUrl != null && video.videoUrl!.isNotEmpty)
            VideoPlayerOrchestrator(videoUrl: video.videoUrl!)
          else if (video.thumbnail != null && video.thumbnail!.isNotEmpty)
            Image.network(video.thumbnail!),
          const SizedBox(height: 16),
          Text(video.id, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          if (video.description != null) Text(video.description!),
        ],
      ),
    );
  }
}