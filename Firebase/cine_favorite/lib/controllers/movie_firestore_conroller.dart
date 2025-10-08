import 'dart:io';
import 'package:cine_favorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieFirestoreController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // Stream de filmes favoritos do usuário logado
  Stream<List<Movie>> getFavoriteMovies() {
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList());
  }

  // Adicionar um filme aos favoritos
  Future<void> addFavoriteMovie(Map<String, dynamic> movieData) async {
    if (currentUser == null) return;

    if (movieData["poster_path"] == null) {
      print("Filme sem imagem. Pulando download...");
      return;
    }

    try {
      final imageUrl =
          "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
      final responseImg = await http.get(Uri.parse(imageUrl));

      final imgDir = await getApplicationDocumentsDirectory();
      final file = File("${imgDir.path}/${movieData["id"]}.jpg");
      await file.writeAsBytes(responseImg.bodyBytes);

      final movie = Movie(
        id: movieData["id"],
        title: movieData["title"],
        posterPath: file.path,
        rating: 0.0,
      );

      await _db
          .collection("users")
          .doc(currentUser!.uid)
          .collection("favorite_movies")
          .doc(movie.id.toString())
          .set(movie.toMap());
    } catch (e) {
      print("Erro ao adicionar filme: $e");
    }
  }

  // Remover um filme dos favoritos
  Future<void> deleteFavoriteMovie(int movieId) async {
    if (currentUser == null) return;

    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .delete();

    try {
      final imgDir = await getApplicationDocumentsDirectory();
      final file = File("${imgDir.path}/$movieId.jpg");
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print("Erro ao deletar imagem: $e");
    }
  }

  // Atualizar avaliação (rating)
  Future<void> updateMovieRating(int movieId, double rating) async {
    if (currentUser == null) return;
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .update({"rating": rating});
  }
}
