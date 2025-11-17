import 'package:flutter/material.dart';
import 'package:justflix_frontend/domain/entities/video_simple.dart';

/// Un widget que muestra un único elemento de video en una lista.
///
/// Muestra la miniatura del video si está disponible, de lo contrario
/// muestra un icono de película por defecto. También maneja los errores
/// de carga de la imagen.
class VideoListItem extends StatelessWidget {
  /// La información del video a mostrar.
  final VideoSimple video;

  /// Callback que se ejecuta cuando se pulsa el elemento de la lista.
  final VoidCallback? onTap;

  const VideoListItem({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell( // Usamos InkWell para que el Card sea pulsable
        onTap: onTap,
        child: ListTile(
          leading: _buildThumbnail(),
          title: Text('Video ID: ${video.id}'),
          subtitle: Text('Duración: ${_formatoDuration(video.duration)}'),
        ),
      ),
    );
  }
  
  /// Construye la miniatura del video.
  ///
  /// Si el video tiene una URL de miniatura, intenta cargarla.
  /// Si falla la carga o no hay URL, muestra un icono por defecto.
  Widget _buildThumbnail() {
    // Comprueba si el thumbnail no es nulo y no está vacío
    if (video.thumbnail != null && video.thumbnail!.isNotEmpty) {
      return Image.network(
        video.thumbnail!,
        fit: BoxFit.cover,
        width: 80,
        // Muestra un indicador de carga mientras la imagen se descarga
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        // Muestra un icono de error si la imagen no se puede cargar
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      );
    } else {
      // Si no hay thumbnail, muestra un icono de película
      return const Icon(Icons.movie, size: 40);
    }
  }
  
  String _formatoDuration(double? seconds) {
    if (seconds == null) {
      return 'N/A';
    }
      final duration = Duration(seconds: seconds.toInt());
      final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
      final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$secs';
  }
}