import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:justflix_frontend/infrastructure/data_sources/videos_api.dart';
import 'package:justflix_frontend/domain/repositories/videos_repositori.dart';
import 'package:justflix_frontend/infrastructure/repository/videos_repository_impl.dart';
import 'package:justflix_frontend/presentation/providers/videos_providers.dart';
import 'package:justflix_frontend/presentation/screens/home_screen.dart'; // Importamos la HomeScreen

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api'; 

    return MultiProvider(
      providers: [
        // Proveedor para la capa de datos
        Provider<VideosApi>(create: (_) => VideosApi(apiBaseUrl)),
        
        // Proveedor para la capa de repositorio
        ProxyProvider<VideosApi, VideosRepository>(
          update: (_, api, __) => VideosRepositoryImpl(api),
        ),

        // Proveedor de estado para la UI
        ChangeNotifierProvider(
          create: (context) => VideosProvider(
            videosRepository: context.read<VideosRepository>(),
          )..loadVideos(), // Cargamos los vídeos al iniciar la app
        ),
      ],
      child: MaterialApp(
        title: 'Justflix',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(), // Usamos la HomeScreen
      ),
    );
  }
}