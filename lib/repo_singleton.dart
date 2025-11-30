import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';
import 'package:justflix_frontend/infrastructure/data_sources/videos_api.dart';
import 'package:justflix_frontend/infrastructure/repository/videos_repository_impl.dart';
import 'package:justflix_frontend/infrastructure/config/app_config.dart';

class RepoSingleton {
  final baseURLBack = AppConfig.backendBaseUrl;
  static RepoSingleton? _instancia;

  late VideosRepository repository;

  factory RepoSingleton() {
    _instancia ??= RepoSingleton._();
    return _instancia!;
  }

  RepoSingleton._() {
    final api = VideosApi(baseURLBack);
    repository = VideosRepositoryImpl(api);
  }
}