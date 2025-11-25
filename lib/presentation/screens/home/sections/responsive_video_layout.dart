import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';
import 'package:justflix_frontend/presentation/screens/home/sections/video_list_section.dart';
import 'package:justflix_frontend/presentation/widgets/video/video_detail.dart';

/// Sección responsable de decidir el layoour responsivo del listado + detalle.
///
class ResponsiveVideoLayout extends StatelessWidget {
  final List<VideoSimple> videos;
  final void Function(String videoId) onVideoSelected;
  final double breakpoint;

  const ResponsiveVideoLayout({
    super.key,
    required this.videos,
    required this.onVideoSelected,
    this.breakpoint =
        600.0, // Definimos un breakpoint para cambiar entre layouts
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth > breakpoint) {
          return _buildSideBySide();
        } else {
          return _buildStacked();
        }
      },
    );
  }

  // Layout vertical
  Widget _buildStacked() {
    return Column(
      children: [
        const Flexible(flex: 2, child: VideoDetail()),
        const Divider(height: 1),
        Flexible(
          flex: 3,
          child: VideoListSection(
            videos: videos,
            onVideoSelected: onVideoSelected,
          ),
        ),
      ],
    );
  }

  // Layout horizontal
  Widget _buildSideBySide() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: VideoListSection(
            videos: videos,
            onVideoSelected: onVideoSelected,
          ),
        ),
        const VerticalDivider(width: 1),
        const Flexible(flex: 3, child: VideoDetail()),
      ],
    );
  }
}
