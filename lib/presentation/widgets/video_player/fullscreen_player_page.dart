import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justflix_frontend/presentation/widgets/video_player/video_view.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayerPage extends StatefulWidget {
  final String videoUrl;
  final Duration startPosition;
  final bool autoPlay;

  const FullscreenPlayerPage({
    super.key,
    required this.videoUrl,
    required this.startPosition,
    required this.autoPlay,
  });

  @override
  State<FullscreenPlayerPage> createState() => _FullscreenPlayerPageState();
}

class _FullscreenPlayerPageState extends State<FullscreenPlayerPage> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  bool _disposed = false;

  bool get controllerActivo =>
      !_disposed && mounted && _controller.value.isInitialized && !_controller.value.isBuffering;

  void _videoListener() {
    if (!_disposed && mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // Crear un controlador propio para fullscreen
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..addListener(_videoListener)
      ..initialize().then((_) async {
        if (!mounted) return;
        await _controller.seekTo(widget.startPosition);
        if (widget.autoPlay) _controller.play();
        setState(() {});
      });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.removeListener(_videoListener);
    _controller.dispose();

    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleControls() {
    if (_disposed) return;
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _safePlayPause() {
    if (!controllerActivo) return;
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _safeSeek(double value) {
    if (!controllerActivo) return;
    _controller.seekTo(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: VideoPlayerView(
          controller: _controller,
          showControls: _showControls,
          isFullscreen: true,
          onToggleControls: _toggleControls,
          onPlayPause: _safePlayPause,
          onSeek: _safeSeek,
          onToggleFullscreen: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
