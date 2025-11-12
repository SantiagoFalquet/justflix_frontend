/// Gestiona las rutas de los recursos estáticos (assets) de la aplicación
class AppAssets {
  /// Imágenes
  static const _baseImages = 'assets/images/';
  static const images = _Images();
}

class _Images {
  const _Images();
  final String logo = '${AppAssets._baseImages}logo_justflix.png';
}
/// Futoro: Añadiro Fuentes, Iconos, Animaciones ...