import 'package:flutter/material.dart';

class VideoOverlay extends StatelessWidget {
  final bool show;

  const VideoOverlay({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.black87, Colors.transparent],
        ),
      ),
    );
  }
}