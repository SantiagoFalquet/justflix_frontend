import 'package:flutter/material.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:provider/provider.dart';

/// Un widget que muestra el detalle de un video seleccionado.
///
/// Escucha a [VideosProvider] para reaccionar a los cambios de estado
/// como la carga, errores, o la selección de un nuevo video.
class VideoDetail extends StatelessWidget {
  const VideoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos un Consumer para escuchar solo los cambios del provider
    // y reconstruir únicamente este widget cuando sea necesario.
    return Consumer<VideosProvider>(
      builder: (context, provider, child) {
        // Estado 1: Cargando el detalle
        if (provider.isLoadingDetail) {
          return const Center(child: CircularProgressIndicator());
        }

        // Estado 2: Error al cargar el detalle
        if (provider.detailError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provider.detailError!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Estado 3: No hay video seleccionado (estado inicial)
        if (provider.selectedVideo == null) {
          return const Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selecciona un video de la lista para ver su detalle',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Estado 4: Hay un video seleccionado y se muestra
        final video = provider.selectedVideo!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.topic,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Duración: ${video.duration?.toStringAsFixed(2) ?? 'N/A'} mins',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(height: 24),
              if (video.thumbnail != null && video.thumbnail!.isNotEmpty) ...[
                Image.network(video.thumbnail!),
                const SizedBox(height: 16),
              ],
              Text(
                video.description ?? 'No hay descripción disponible.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}