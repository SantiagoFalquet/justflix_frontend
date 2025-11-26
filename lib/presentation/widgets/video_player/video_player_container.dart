import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_view.dart';
import 'package:video_player/video_player.dart';

/// Un widget sin estado que simplemente muestra la vista del reproductor de vídeo.
/// Recibe toda la lógica y el estado desde un widget superior (el orquestador).
class VideoPlayerContainer extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showControls;
  final VoidCallback onToggleControls;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;
  final VoidCallback onToggleFullscreen;

  const VideoPlayerContainer({
    super.key,
    required this.controller,
    required this.showControls,
    required this.onToggleControls,
    required this.onPlayPause,
    required this.onSeek,
    required this.onToggleFullscreen,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return VideoPlayerView(
      controller: controller,
      showControls: showControls,
      isFullscreen: false, // En esta vista, nunca estamos en pantalla completa.
      onToggleControls: onToggleControls,
      onPlayPause: onPlayPause,
      onSeek: onSeek,
      onToggleFullscreen: onToggleFullscreen,
    );
  }
}
