import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:justflix_frontend/utils/formatters.dart';

class VideoPlayerView extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showControls;

  final VoidCallback onToggleControls;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;
  final ValueChanged<double>? onSeekStart;
  final ValueChanged<double>? onSeekEnd;

  const VideoPlayerView({
    super.key,
    required this.controller,
    required this.showControls,
    required this.onToggleControls,
    required this.onPlayPause,
    required this.onSeek,
    this.onSeekStart,
    this.onSeekEnd,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final pos = controller.value.position;
    final dur = controller.value.duration;

    return GestureDetector(
      onTap: onToggleControls,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller),

            // Gradientes sobre controlers.
            if (showControls)
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
            if (showControls)
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

            // Barra inferior
            if (showControls)
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
