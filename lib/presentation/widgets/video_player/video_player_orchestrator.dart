import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_player_container.dart';
import 'package:video_player/video_player.dart';
import 'fullscreen_player_page.dart';

class VideoPlayerOrchestrator extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerOrchestrator({super.key, required this.videoUrl});

  @override
  State<VideoPlayerOrchestrator> createState() =>
      _VideoPlayerOrchestratorState();
}

class _VideoPlayerOrchestratorState extends State<VideoPlayerOrchestrator> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  bool _isInFullscreen = false;

  void _videoListener() {
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
  void didUpdateWidget(covariant VideoPlayerOrchestrator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isInFullscreen && oldWidget.videoUrl != widget.videoUrl) {
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

  // --- Callbacks ---

  void _handlePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _handleSeek(double value) {
    _controller.seekTo(Duration(seconds: value.toInt()));
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  // --- ✔ FULLSCREEN FIJO Y SEGURO ---
  Future<void> _handleToggleFullscreen() async {
    _isInFullscreen = true;

    final wasPlaying = _controller.value.isPlaying;
    final currentPosition = await _controller.position ?? Duration.zero;

    // Pausa el video antes de empujar la nueva ruta
    await _controller.pause();

    // --- fullscreen con un NUEVO controller ---
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullscreenPlayerPage(
          videoUrl: widget.videoUrl,
          startPosition: currentPosition,
          autoPlay: wasPlaying,
        ),
      ),
    );

    // Al volver: retomamos posición y estado
    await _controller.seekTo(currentPosition);
    if (wasPlaying) _controller.play();

    _isInFullscreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerContainer(
      controller: _controller,
      showControls: _showControls,
      onToggleControls: _toggleControls,
      onPlayPause: _handlePlayPause,
      onSeek: _handleSeek,
      onToggleFullscreen: _handleToggleFullscreen,
    );
  }
}
