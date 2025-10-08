import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbService {
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseURL = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";

  // Buscar filmes pelo nome
  static Future<List<Map<String, dynamic>>> searchMovie(String movie) async {
    try {
      final encodedMovie = Uri.encodeQueryComponent(movie);
      final apiURI = Uri.parse(
        "$_baseURL/search/movie?api_key=$_apiKey&query=$encodedMovie&language=$_idioma",
      );

      final response = await http.get(apiURI);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data["results"]);
      } else {
        throw Exception(
          "Erro ${response.statusCode}: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      throw Exception("Falha ao conectar com o TMDB: $e");
    }
  }

  // Buscar detalhes de um filme pelo ID
  static Future<Map<String, dynamic>> getMovieById(int id) async {
    final apiURI = Uri.parse(
      "$_baseURL/movie/$id?api_key=$_apiKey&language=$_idioma",
    );

    final response = await http.get(apiURI);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao buscar filme pelo ID ($id)");
    }
  }
}
