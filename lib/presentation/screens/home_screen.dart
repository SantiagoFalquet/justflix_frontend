import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/widgets/video_list_item.dart';
import 'package:justflix_frontend/presentation/widgets/video_detail.dart'; // Importamos el nuevo widget
import 'package:justflix_frontend/assets.dart';

/// Pantalla principal que muestra una lista de videos y su detalle de forma responsiva.
///
/// Gestiona la carga, visualización y manejo de errores/estados vacíos
/// de la lista de videos a través de [VideosProvider].
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Definimos un breakpoint para cambiar entre layouts
  static const double _breakpoint = 600.0;

  @override
  void initState() {
    super.initState();
    // Carga los videos cuando la pantalla se inicializa.
    Provider.of<VideosProvider>(context, listen: false).loadVideos();
  }

  /// Maneja la selección de un video de la lista.
  /// Carga el detalle completo del video usando el provider.
  void _handleVideoSelected(String videoId) {
    Provider.of<VideosProvider>(context, listen: false).loadVideoById(videoId);
  }

  @override
  Widget build(BuildContext context) {
    // Observa los cambios en VideosProvider para reconstruir la UI.
    final videosProvider = context.watch<VideosProvider>();

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Justflix - Videos'),
        /// Mostra el logo de la aplicación en el AppBar.
        /// Logo está en la ruta assets y declarada en pubspec.yml
        title: Image.asset(AppAssets.images.logo, height: 40),
        /* actions: [
          // Botón para limpiar la selección del video de detalle
          if (videosProvider.selectedVideo != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                videosProvider.clearSelectedVideo();
              },
              tooltip: 'Limpiar selección',
            ),
          // Botón para recargar la lista de videos
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              videosProvider.loadVideos();
              videosProvider.clearSelectedVideo(); // Limpiar detalle al recargar lista
            },
            tooltip: 'Recargar videos',
          ),
        ], */
      ),
      body: _buildBody(videosProvider),
      // El FloatingActionButton original se ha movido a la AppBar como IconButton
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

    // Si no hay errores, no está cargando y hay videos, muestra el LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > _breakpoint) {
          // Diseño lado a lado para pantallas anchas
          return _buildSideBySideLayout(videosProvider);
        } else {
          // Diseño apilado para pantallas estrechas
          return _buildStackedLayout(videosProvider);
        }
      },
    );
  }

  /// Construye el diseño apilado (vertical) para pantallas estrechas.
  Widget _buildStackedLayout(VideosProvider videosProvider) {
    return Column(
      children: [
        // Zona 2: Detalle del video (ocupa un espacio fijo o flexible)
        // Aquí usamos un Flexible para que el detalle no empuje la lista fuera de la pantalla
        Flexible(
          flex: 2, // Puedes ajustar la proporción
          child: VideoDetail(),
        ),
        const Divider(height: 1),
        // Zona 3: Lista de videos (ocupa el espacio restante)
        Flexible(
          flex: 3, // Puedes ajustar la proporción
          child: _buildVideoList(videosProvider),
        ),
      ],
    );
  }

  /// Construye el diseño lado a lado (horizontal) para pantallas anchas.
  Widget _buildSideBySideLayout(VideosProvider videosProvider) {
    return Row(
      children: [
        // Zona 3: Lista de videos (ocupa una parte del ancho)
        Flexible(
          flex: 2, // Puedes ajustar la proporción
          child: _buildVideoList(videosProvider),
        ),
        const VerticalDivider(width: 1),
        // Zona 2: Detalle del video (ocupa el resto del ancho)
        Flexible(
          flex: 3, // Puedes ajustar la proporción
          child: VideoDetail(),
        ),
      ],
    );
  }

  /// Widget auxiliar para construir la lista de videos.
  Widget _buildVideoList(VideosProvider videosProvider) {
    return ListView.builder(
      itemCount: videosProvider.videos.length,
      itemBuilder: (context, index) {
        final video = videosProvider.videos[index];
        return VideoListItem(
          video: video,
          onTap: () => _handleVideoSelected(video.id),
        );
      },
    );
  }
}
