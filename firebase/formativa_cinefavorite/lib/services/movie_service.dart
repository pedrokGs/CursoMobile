import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:formativa_cinefavorite/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();

  Stream<List<Movie>> getFavoriteMovies() {
    if (_authService.currentUser == null) return Stream.value([]);
    try {
      return _firestore
          .collection("users")
          .doc(_authService.currentUser!.uid)
          .collection("favoriteMovies")
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList(),
          );
    } catch (e) {
      rethrow;
    }
  }

  void addMovieToFavorites(
    Movie movie,
  ) async {
    print("sem poster");
    if (movie.posterPath.isEmpty || _authService.currentUser == null) {
      return null;
    }

    final imagemUrl = "https://image.tmdb.org/t/p/w500${movie.posterPath}";
    final responseImg = await http.get(Uri.parse(imagemUrl));

    final appDir = await getApplicationDocumentsDirectory();
    final file = File("${appDir.path}/${movie.id}.jpg");
    await file.writeAsBytes(responseImg.bodyBytes);

    Map<String, dynamic> movieJson = movie.toMap();
    movieJson["poster_path"] = file.path.toString();

    try {
      await _firestore
          .collection("users")
          .doc(_authService.currentUser!.uid)
          .collection("favoriteMovies")
          .doc(movie.id)
          .set(movieJson);

    } catch (e) {
      rethrow;
    }
  }

  void removeFavoriteMovie(String movieId) async {
    if (_authService.currentUser == null) return;

    try {
      await _firestore
          .collection("users")
          .doc(_authService.currentUser!.uid)
          .collection("favoriteMovies")
          .doc(movieId)
          .delete()
          .then((_) async {
            final imagePath = await getApplicationDocumentsDirectory();
            final imageFile = File("${imagePath.path}/$movieId");

            await imageFile.delete();
          });
    } catch (e) {
      rethrow;
    }
  }

  void updateMovieRating(String movieId, double rating) async{
    if(_authService.currentUser == null) return;

    await _firestore.collection("users").doc(_authService.currentUser!.uid)
    .collection("favorite_movies").doc(movieId).update({"rating": rating});
  }
}
