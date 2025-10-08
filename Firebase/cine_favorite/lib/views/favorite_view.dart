import 'dart:io';
import 'package:cine_favorite/controllers/movie_firestore_conroller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView>
    with SingleTickerProviderStateMixin {
  final _movieController = MovieFirestoreController();
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color softBlue = const Color(0xFFDBEAFE); // azul clarinho
    final Color accentBlue = const Color(0xFF60A5FA); // azul do botão/lupa

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: softBlue,
        elevation: 0,
        title: const Text(
          "Favoritos",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black54),
            onPressed: FirebaseAuth.instance.signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search favorites",
                prefixIcon: Icon(Icons.search, color: accentBlue),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: softBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: accentBlue),
                ),
              ),
            ),
          ),

          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: accentBlue,
            labelColor: accentBlue,
            unselectedLabelColor: Colors.black54,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            tabs: const [
              Tab(text: "Favorites"),
              Tab(text: "Top 10"),
              Tab(text: "Popular"),
              Tab(text: "Downloaded"),
            ],
          ),

          // Conteúdo das abas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Aba "Favorites"
                _buildFavoritesTab(),
                _buildPlaceholder("Top 10 ainda não disponível"),
                _buildPlaceholder("Populares em breve"),
                _buildPlaceholder("Downloadados em breve"),
              ],
            ),
          ),
        ],
      ),

      // Botão de busca
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentBlue,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchMovieView()),
        ),
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return StreamBuilder<List<Movie>>(
      stream: _movieController.getFavoriteMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Erro ao carregar a lista de favoritos"));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoriteMovies = snapshot.data!;
        if (favoriteMovies.isEmpty) {
          return const Center(
              child: Text("Nenhum filme adicionado aos favoritos"));
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: favoriteMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.file(
                          File(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        "Nota: ${movie.rating}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
