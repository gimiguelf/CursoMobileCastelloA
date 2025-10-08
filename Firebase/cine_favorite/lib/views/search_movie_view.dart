import 'package:cine_favorite/controllers/movie_firestore_conroller.dart';
import 'package:cine_favorite/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final _favMovieController = MovieFirestoreController();
  final _searchField = TextEditingController();
  List<Map<String, dynamic>> _movies = [];
  bool _isLoading = false;

  void _searchMovies() async {
    final termo = _searchField.text.trim();
    if (termo.isEmpty) return;

    FocusScope.of(context).unfocus(); // fecha o teclado
    setState(() => _isLoading = true);

    try {
      final result = await TmdbService.searchMovie(termo);
      _movies = result;
    } catch (e) {
      _movies = [];
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Filmes")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _searchField,
              decoration: InputDecoration(
                labelText: "Nome do Filme",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _searchMovies,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _movies.isEmpty
                      ? Center(child: Text("Nenhum Filme Encontrado"))
                      : ListView.builder(
                          itemCount: _movies.length,
                          itemBuilder: (context, index) {
                            final movie = _movies[index];
                            return ListTile(
                              leading: Image.network(
                                "https://image.tmdb.org/t/p/w500${movie["poster_path"] ?? ""}",
                                height: 50,
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.broken_image),
                              ),
                              title: Text(movie["title"] ?? "Sem título"),
                              subtitle:
                                  Text(movie["release_date"] ?? "Sem data"),
                              trailing: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () async {
                                  await _favMovieController
                                      .addFavoriteMovie(movie);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${movie["title"]} adicionado com sucesso!"),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
