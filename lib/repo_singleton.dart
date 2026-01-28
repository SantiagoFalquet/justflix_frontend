import 'package:justflix_frontend/domain/repositories/videos_repository.dart';
import 'package:justflix_frontend/infrastructure/data_sources/videos_api.dart';
import 'package:justflix_frontend/infrastructure/repository/videos_repository_impl.dart';
import 'package:justflix_frontend/infrastructure/config/app_config.dart';

class RepoSingleton {
  final baseURLBack = AppConfig.backendBaseUrl;
  
  /// Instancia privada estatica
  static RepoSingleton? _instancia;

  /// Referencia al repositorio (clase abstracta)
  late VideosRepository repository;

  /// Construcor de factoria:
  /// para asegurar que devuelva una única instáncia
  factory RepoSingleton() {
    _instancia ??= RepoSingleton._();
    return _instancia!;
  }

  // Constructor privado
  RepoSingleton._() {
    // Inicialización del repositorio
    final api = VideosApi(baseURLBack);
    // Inyección de dependencia (inyectamos al repositorio)
    repository = VideosRepositoryImpl(api); // Inyección de dependencia
  }
}