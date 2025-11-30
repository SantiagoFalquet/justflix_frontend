import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/utils/formatters.dart';
import 'package:justflix_frontend/presentation/widgets/shared/video_thumbnail.dart';

/// Widget que muestra un único elemento de video en una lista.
class VideoListItem extends StatelessWidget {
  final VideoSimple video;
  final VoidCallback? onTap;

  const VideoListItem({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        onTap: onTap,
        leading: VideoThumbnail(thumbnailUrl: video.thumbnail),
        title: Text(video.id),
        subtitle: Text('Duración: ${formatoDuration(video.duration)}'),
      ),
    );
  }
}