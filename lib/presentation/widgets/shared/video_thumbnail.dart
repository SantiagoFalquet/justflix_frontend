import 'package:flutter/material.dart';

/// Muestra la miniatura de un vídeo.
///
/// - Si [thumbnailUrl] es válida, carga la img desde la red.
/// - Si la imagen tarda en cargar, muestra un indicador de progreso [CircularProgressIndicator].
/// - Si falla la carga o [thumbnailUrl] es nula/vacia, muestra un icono por defecto [Icons.broken_image].
///
class VideoThumbnail extends StatelessWidget {
  /// URL de la miniatura del video.
  final String? thumbnailUrl;

  /// Ancho y alto del widget.
  final double width;
  final double height;

  const VideoThumbnail({
    super.key,
    this.thumbnailUrl,
    this.width = 80.0,
    this.height = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      return Image.network(
        thumbnailUrl!,
        fit: BoxFit.cover,
        width: width,
        height: height,
        // Muestra un indicador de carga mientras la imagen se descarga
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        // Muestra un icono de error si la imagen no se puede cargar
        errorBuilder: (context, error, stackTrace) {
          print('[ERROR] - Al cargar la imagen: $error');
          return _buildErrorPlaceholder();
        },
      );
    } else {
      // Si no hay thumbnail, muestra un icono de película
      return _peliculaPlaceholder();
    }
  }

  /// Widget de reemplazo que muestra un icono de error si la imagen no se puede cargar.
  /// 
  Widget _buildErrorPlaceholder() {
    return SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.broken_image, size: 40),
      );
  }
  
  /// Widget de reemplazo que si no hay thumbnail, muestra un icono de película.
  /// 
  Widget _peliculaPlaceholder() {
    return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.movie, size: 40, color: Colors.grey,),
      );
  }
}
