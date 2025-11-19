import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:justflix_frontend/utils/formatters.dart';

class VideoControls extends StatelessWidget {
  final VideoPlayerValue value;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;

  const VideoControls({
    super.key,
    required this.value,
    required this.onPlayPause,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final pos = value.position;
    final dur = value.duration;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              value.isPlaying
                  ? Icons.pause_circle_outline
                  : Icons.play_circle_outline,
              color: Colors.white,
              size: 60,
            ),
            onPressed: onPlayPause,
          ),

          // Barra inferior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    max: pos.inSeconds.toDouble(),
                    value: pos.inSeconds.toDouble().clamp(
                      0,
                      dur.inSeconds.toDouble(),
                    ),
                    onChanged: onSeek,
                  ),
                ),
                Text(
                  formatDurationFromDuration(dur),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
