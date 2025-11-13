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
  bool _showControls = true; // Nuevo: para mostrar/ocultar controles

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose(); // ¡Asegúrate de que esto sea super.dispose() con paréntesis!
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

  // Nuevo: Función auxiliar para formatear la duración
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _showControls = !_showControls;
              });
            },
            // El AspectRatio debe envolver al Stack para darle un tamaño definido.
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // 1. El vídeo como fondo del Stack
                  VideoPlayer(_controller),

                  // 2. Un gradiente para que los controles se lean mejor
                  if (_showControls)
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black87, Colors.transparent],
                        ),
                      ),
                    ),

                  // 3. El botón de Play/Pausa en el centro
                  if (_showControls)
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          color: Colors.white,
                          size: 60,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ),

                  // 4. La barra de controles en la parte inferior
                  if (_showControls)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller,
                        builder: (context, value, child) {
                          final pos = value.position;
                          final dur = value.duration;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  _formatDuration(pos),
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                Expanded(
                                  child: Slider(
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.white54,
                                    min: 0,
                                    max: dur.inSeconds.toDouble(),
                                    value: pos.inSeconds.toDouble().clamp(
                                      0,
                                      dur.inSeconds.toDouble(),
                                    ),
                                    onChanged: (newVal) {
                                      _controller.seekTo(Duration(seconds: newVal.toInt()));
                                    },
                                  ),
                                ),
                                Text(
                                  _formatDuration(dur),
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          )
        
      : const Center(child: CircularProgressIndicator());
  }
}
