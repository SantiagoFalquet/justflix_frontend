// Aquesta classe és la que interactúa amb l'API per obtenir la informació
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VideosApi {
  /// Aquesta és la URL base, que es proporcionarà en el moment de la instanciació.
  /// Inyección de dependencia
  final String baseURL;

  // Constructor para crear una instancia de [VideosApi]
  VideosApi(
    this.baseURL
    );

  // Obté una llista de JSON amb el resultat de l'API
  Future<List<dynamic>> getVideos(String searchQuery) async {
    final Uri url;

    if (searchQuery.isEmpty) {
      url = Uri.parse(baseURL);
    } else {
      url = Uri.parse('$baseURL/topic/$searchQuery');
    }

    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final body = utf8.decode(response.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;
      return bodyJSON;
    } else {
      throw Exception('Error al obtener vídeos: ${response.statusCode}');
    }
  }

  /// Obtener información de un video específico en formato JSON.
  Future<Map<String, dynamic>> getVideoById(String videoId) async {
    final url = Uri.parse('$baseURL/$videoId');
    final response = await http.get(url);
    
    if (response.statusCode == HttpStatus.ok) {
      final body = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonMap = jsonDecode(body);
      return jsonMap;
    } else {
      throw Exception('Error al obtener vídeos $videoId: ${response.statusCode}');
    }
  }
}
