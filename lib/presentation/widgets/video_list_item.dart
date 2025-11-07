import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';

class VideoListItem extends StatelessWidget {
  final VideoSimple video;

  const VideoListItem({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: _buildThumbnail(),
        title: Text('Video ID: ${video.id}'),
      ),
    );
  }
  
  Widget _buildThumbnail() {
    if (video.thumbnail != null && video.thumbnail!.isNotEmpty) {
      return Image.network(
        video.thumbnail!,
        fit: BoxFit.cover,
        width: 80,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      );
    } else {
      return const Icon(Icons.movie, size: 40);
    }
  }
}