import 'package:flutter/material.dart';

/// Muestra la miniatura de un vídeo.
/// 
/// - sI [url] es válida, carga la img desde la red.
/// - Si la imagen tarda en cargar, muestra un indicador de progreso [CircularProgressIndicator].
/// - Si falla la carga o [url] es nula/vacia, meustra un icono por defecto [Icons.broken_image].
/// 
class VideoThumbnail extends StatelessWidget {
  /// URL de la miniatura del video.
  final String? url;
  const VideoThumbnail({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
      return Image.network(
        url!,
        fit: BoxFit.cover,
        width: 80,
        height: 80,
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
}
