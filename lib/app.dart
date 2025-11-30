import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:justflix_frontend/presentation/screens/home/home_screen.dart';

/// Widget raíz de la aplicación.
///
/// Se encarga de preparar toda la estructura inicial antes de mostrar la UI.
/// Se configura los proveedores necesarios para obtener datos, acceder
/// al repositorio de videos y manejar los esatdo de la aplicación.
///
const seed = Color(0xFF6750A4); // Color llavor

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDyn, ColorScheme? darkDyn) {
        final ColorScheme light =
            (lightDyn?.harmonized()) ??
                ColorScheme.fromSeed(
                    seedColor: seed, brightness: Brightness.light);

        final ColorScheme dark =
            (darkDyn?.harmonized()) ??
                ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);

        return MaterialApp(
          title: 'Justflix',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorScheme: light),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: dark),
          home: const HomeScreen(),
        );
      },
    );
  }
}
