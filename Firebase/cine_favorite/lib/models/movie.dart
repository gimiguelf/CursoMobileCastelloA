// Classe de modelagem de dados para Movie
class Movie {
  // Atributos
  final int id; // Id do TMDB
  final String title; // Título do filme
  final String posterPath; // Caminho da imagem do poster
  double rating; // Nota que o usuário dará ao filme

  // Construtor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  // Converte o objeto para Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  // Cria um objeto Movie a partir de um Map (ao ler do Firestore)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map["id"] ?? 0,
      title: map["title"] ?? "Título desconhecido",
      posterPath: map["posterPath"] ?? "",
      rating: (map["rating"] is num) ? (map["rating"] as num).toDouble() : 0.0,
    );
  }

  // Cria uma cópia do objeto alterando apenas os campos desejados
  Movie copyWith({
    int? id,
    String? title,
    String? posterPath,
    double? rating,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      rating: rating ?? this.rating,
    );
  }
}
