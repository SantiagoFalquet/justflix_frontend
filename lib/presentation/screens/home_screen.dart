import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videosProvider = context.watch<VideosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Justflix - Videos'),
      ),
      body: videosProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videosProvider.videos.length,
              itemBuilder: (context, index) {
                final video = videosProvider.videos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    leading: const Icon(Icons.movie),
                    title: Text('Video ID: ${video.id}'),
                  ),
                );
              },
            ),
    );
  }
}