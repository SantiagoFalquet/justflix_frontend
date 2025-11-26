import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/controls/video_controls.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatelessWidget {
  final VideoPlayerController controller;
  final bool showControls;
  final bool isFullscreen;

  final VoidCallback onToggleControls;
  final VoidCallback onPlayPause;
  final VoidCallback onToggleFullscreen;
  final ValueChanged<double> onSeek;
  final ValueChanged<double>? onSeekStart;
  final ValueChanged<double>? onSeekEnd;

  const VideoPlayerView({
    super.key,
    required this.controller,
    required this.showControls,
    required this.isFullscreen,
    required this.onToggleControls,
    required this.onPlayPause,
    required this.onToggleFullscreen,
    required this.onSeek,
    this.onSeekStart,
    this.onSeekEnd,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: onToggleControls,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(controller),
            if (showControls)
              VideoControls(
                controller: controller,
                isFullscreen: isFullscreen,
                onPlayPause: onPlayPause,
                onToggleFullscreen: onToggleFullscreen,
                onSeek: onSeek,
                onSeekStart: onSeekStart,
                onSeekEnd: onSeekEnd,
              ),
          ],
        ),
      ),
    );
  }
}
