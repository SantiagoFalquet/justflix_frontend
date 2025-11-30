// Aquesta classe és la que interactúa amb l'API per obtenir la informació
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VideosApi {
  /// Aquesta és la URL base, que es proporcionarà en el moment de la instanciació.
  /// Inyección de dependencia
  final String baseURL;

  // Constructor para crear una instancia de [VideosApi]
  VideosApi(this.baseURL);

  // Obté una llista de JSON amb el resultat de l'API
  Future<List<dynamic>> getVideos(String searchQuery) async {
    String url = "$baseURL/api/videos";
    
    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;
      
      return bodyJSON;
    } else {
      throw [];
    }
  }

  /// Obtener información de un video específico en formato JSON.
  Future<Map<String, dynamic>> getVideoById(String videoId) async {
    String url = "$baseURL/api/videos/$videoId";

    http.Response data = await http.get(Uri.parse(url));

    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);
      
      return bodyJSON;
    } else {
      throw {};
    }
  }
}
