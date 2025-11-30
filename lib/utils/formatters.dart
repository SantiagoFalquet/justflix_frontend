/// Formatea una duración en segundos a un formato de cadena 'mm:ss'.
/// Devuelve 'N/A' si [seconds] es nulo, negativo o no válido.
///
String formatoDuration(double? seconds) {
  // Validación
  if (seconds == null || seconds < 0) {
    return 'N/A';
  }
  // Convertir los segundos a un objeto Duration
  final duration = Duration(seconds: seconds.toInt());

  return formatDurationFromDuration(duration);
}
String formatDurationFromDuration(Duration duration) {
  // Obtener minutos y segundos, asegurando 2 dígitos con padLeft
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$minutes:$seconds";
}