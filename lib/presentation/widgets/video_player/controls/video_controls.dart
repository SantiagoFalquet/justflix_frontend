import 'package:flutter/material.dart';
import 'package:justflix_frontend/utils/formatters.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isFullscreen;

  final VoidCallback onPlayPause;
  final VoidCallback onToggleFullscreen;
  final ValueChanged<double> onSeek;
  final ValueChanged<double>? onSeekStart;
  final ValueChanged<double>? onSeekEnd;

  const VideoControls({
    super.key,
    required this.controller,
    required this.isFullscreen,
    required this.onPlayPause,
    required this.onToggleFullscreen,
    required this.onSeek,
    this.onSeekStart,
    this.onSeekEnd,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox.shrink();
    }
    final pos = controller.value.position;
    final dur = controller.value.duration;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Gradiente para mejorar la legibilidad de los controles
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black87, Colors.transparent],
            ),
          ),
        ),

        // Botón central de play/pause
        Center(
          child: IconButton(
            icon: Icon(
              controller.value.isPlaying
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline,
              color: Colors.white,
              size: 60,
            ),
            onPressed: onPlayPause,
          ),
        ),

        // Barra inferior de controles
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  formatDurationFromDuration(pos),
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
                    onChanged: onSeek,
                    onChangeStart: onSeekStart,
                    onChangeEnd: onSeekEnd,
                  ),
                ),
                Text(
                  formatDurationFromDuration(dur),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  ),
                  onPressed: onToggleFullscreen,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
