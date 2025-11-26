import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/infrastructure/data_sources/videos_api.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';
import 'package:justflix_frontend/infrastructure/repository/videos_repository_impl.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/screens/home/home_screen.dart';
import 'package:justflix_frontend/infrastructure/config/app_config.dart';

/// Widget raíz de la aplicación.
///
/// Se encarga de preparar toda la estructura inicial antes de mostrar la UI.
/// Se configura los proveedores necesarios para obtener datos, acceder
/// al repositorio de videos y manejar los esatdo de la aplicación.
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // URL base de la API de flutter + puerto (.env)
    final String apiBaseUrl = AppConfig.apiUrl;

    return MultiProvider(
      providers: [
        // Proveedor para la capa de datos. Crea la instancia q se comunica
        // directamente con la API remota
        Provider<VideosApi>(create: (_) => VideosApi(apiBaseUrl)),

        // Proveedor para la capa de repositorio.
        // Capa intermedia entra la API y la lógica de la aplicación
        ProxyProvider<VideosApi, VideosRepository>(
          update: (_, api, __) => VideosRepositoryImpl(api),
        ),

        // Proveedor de estado que gestiona la lógica usadaen la UI.
        ChangeNotifierProvider(
          create: (context) =>
              VideosProvider(videosRepository: context.read<VideosRepository>())
                ..loadVideos(), // Cargamos los vídeos al iniciar la app
        ),
      ],

      // Aplicación principal de Flutter
      child: MaterialApp(
        title: 'Justflix',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
