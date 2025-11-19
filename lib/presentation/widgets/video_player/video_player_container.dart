import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_view.dart';
import 'package:video_player/video_player.dart';

/// Contenedor responsable de gestionar el ciclo de vidas del [VideoPlayerContainer].
///
class VideoPlayerContainer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerContainer({super.key, required this.videoUrl});

  @override
  State<VideoPlayerContainer> createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  bool _isSeeking = false;
  bool _wasPlayingBeforeSeek = false;

  void _videoListener() {
    if (_isSeeking) {
      return;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _createController(widget.videoUrl);
  }

  void _createController(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    _controller.addListener(_videoListener);
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la URL del video cambia, reiniciamos el controller.
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.removeListener(_videoListener);
      _controller.dispose();
      _createController(widget.videoUrl);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _handleSeekStart(double value) {
    if (!_controller.value.isInitialized) {
      return;
    }
    setState(() {
      _isSeeking = true;
      _wasPlayingBeforeSeek = _controller.value.isPlaying;
      if (_wasPlayingBeforeSeek) {
        _controller.pause();
      }
    });
  }

  void _handleSeekEnd(double value) {
    if (!_controller.value.isInitialized) {
      return;
    }
    if (_wasPlayingBeforeSeek) {
      _controller.play();
    }
    setState(() {
      _isSeeking = false;
    });
  }

  // alterna la visibilidad de los controles.
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
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
      onSeekStart: _handleSeekStart,
      onSeekEnd: _handleSeekEnd,
    );
  }
}
