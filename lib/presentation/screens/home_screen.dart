import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/widgets/video_list_item.dart';

/// Pantalla principal que muestra una lista de videos.
///
/// Gestiona la carga, visualización y manejo de errores/estados vacíos
/// de la lista de videos a través de [VideosProvider].
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carga los videos cuando la pantalla se inicializa.
    // Usamos listen: false porque solo queremos llamar a un método,
    // no reconstruir el widget basado en cambios aquí.
    Provider.of<VideosProvider>(context, listen: false).loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    // Observa los cambios en VideosProvider para reconstruir la UI.
    final videosProvider = context.watch<VideosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Justflix - Videos'),
      ),
      body: _buildBody(videosProvider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Recarga los videos al presionar el botón.
          videosProvider.loadVideos();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  /// Construye el cuerpo de la pantalla basándose en el estado del provider.
  Widget _buildBody(VideosProvider videosProvider) {
    if (videosProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (videosProvider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Text(
                videosProvider.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => videosProvider.loadVideos(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (videosProvider.videos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam_off, size: 50, color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                'No se encontraron videos.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => videosProvider.loadVideos(),
                child: const Text('Buscar de nuevo'),
              ),
            ],
          ),
        ),
      );
    }

    // Si no hay errores, no está cargando y hay videos, muestra la lista.
    return ListView.builder(
      itemCount: videosProvider.videos.length,
      itemBuilder: (context, index) {
        final video = videosProvider.videos[index];
        return VideoListItem(video: video);
      },
    );
  }
}
