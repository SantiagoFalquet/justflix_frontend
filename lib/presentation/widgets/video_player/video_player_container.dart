import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_view.dart';
import 'package:video_player/video_player.dart';

/// Contenedor responsable de gestionar el ciclo de vidas del [VideoPlayerContainer].
/// 
class VideoPlayerContainer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerContainer({
    super.key,
    required this.videoUrl,
    
  });

  @override
  State<VideoPlayerContainer> createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _createController(widget.videoUrl);
  }

  void _createController(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la URL del video cambia, reiniciamos el controller.
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _createController(widget.videoUrl);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // alterna la visibilidad de los controles.
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized){
      return const Center(child: CircularProgressIndicator());
    }

    return VideoPlayerView(
      controller: _controller,
      showControls: _showControls,
      onToggleControls: _toggleControls,
      onPlayPause: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      onSeek: (value) {
        final position = Duration(seconds: value.toInt());
        _controller.seekTo(position);
      },
    );
  }
}
