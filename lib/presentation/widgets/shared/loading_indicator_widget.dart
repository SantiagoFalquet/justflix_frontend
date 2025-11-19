import 'package:flutter/material.dart';

/// Muestra un indicador de carga centrado en la pantalla.
/// 
class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}