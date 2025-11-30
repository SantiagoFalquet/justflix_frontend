import 'package:flutter/material.dart';

/// Widget que muestra un estado vacío cuando no hay datos que mostrar.
/// 
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const EmptyStateWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 60, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Intentar de nuevo'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
