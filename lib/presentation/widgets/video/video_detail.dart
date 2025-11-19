import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_player_container.dart';


/// Un widget que muestra el detalle de un video seleccionado.
///
/// Escucha a [VideosProvider] para reaccionar a los cambios de estado
/// como la carga, errores, o la selección de un nuevo video.
///
class VideoDetail extends StatelessWidget {
  const VideoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideosProvider>(
      builder: (_, provider, __) {
        if (provider.isLoadingDetail) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.detailError != null) {
          return Center(child: Text(provider.detailError!));
        }

        if (provider.selectedVideo == null) {
          return const Center(
            child: Text('Selecciona un vídeo para ver su detalle'),
          );
        }

        return _VideoDetailContent(video: provider.selectedVideo!);
      },
    );
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
            VideoPlayerContainer(videoUrl: video.videoUrl!)
          else if (video.thumbnail != null && video.thumbnail!.isNotEmpty)
            Image.network(video.thumbnail!),

          const SizedBox(height: 16),
          Text(video.topic, style: Theme.of(context).textTheme.headlineSmall),
          
          const SizedBox(height: 8),
          if (video.description != null) 
            Text(video.description!),
        ],
      ),
    );
  }
}