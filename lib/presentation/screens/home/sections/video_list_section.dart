import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/presentation/widgets/video/video_card.dart';

/// Sección que muestra la lista de videos.
class VideoListSection extends StatelessWidget {
  final List<VideoSimple> videos;
  final void Function(String videoId) onVideoSelected;

  const VideoListSection({
    super.key,
    required this.videos,
    required this.onVideoSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoListItem(
          video: video,
          onTap: () => onVideoSelected(video.id),
        );
      },
    );
  }
}
