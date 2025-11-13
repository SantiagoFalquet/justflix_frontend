import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/domain/entities/video.dart';
import 'package:video_player/video_player.dart';

/// Un widget que muestra el detalle de un video seleccionado.
///
/// Escucha a [VideosProvider] para reaccionar a los cambios de estado
/// como la carga, errores, o la selección de un nuevo video.
class VideoDetail extends StatelessWidget {
  const VideoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideosProvider>(
      builder: (context, provider, child) {
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
            _VideoPlayerWidget(videoUrl: video.videoUrl!)
          else if (video.thumbnail != null && video.thumbnail!.isNotEmpty)
            Image.network(video.thumbnail!),
          const SizedBox(height: 16),
          Text(video.topic, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          if (video.description != null) ...[
            Text(video.description!),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const _VideoPlayerWidget({required this.videoUrl});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        // _controller.play(); // auto-play
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
