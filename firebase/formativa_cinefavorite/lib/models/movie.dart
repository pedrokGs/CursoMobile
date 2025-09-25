class Movie {
  final String id;
  final String title;
  final String posterPath;

  double rating;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "poster_path": posterPath,
      "rating": rating,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map["id"].toString(),
      title: map["title"] ?? "",
      posterPath: map["poster_path"] ?? "",
    );
  }
}
