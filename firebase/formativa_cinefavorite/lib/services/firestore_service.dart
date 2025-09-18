import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:formativa_cinefavorite/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();

  Stream<List<Movie>> getFavoriteMovies() {
    if (_authService.currentUser == null) return Stream.value([]);
try{
    return _firestore
        .collection("users")
        .doc(_authService.currentUser!.uid)
        .collection("favoriteMovies")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList(),
        );
} catch(e){
  rethrow;
}
  }

  void addMovieToFavorites(Movie movie) async {
  if(movie.posterPath.isEmpty) return;

  final imagemUrl = "https://image.tmdb.org/t/p/w500${movie.posterPath}";
  final responseImg = await http.get(Uri.parse(imagemUrl));

  final appDir = await getApplicationDocumentsDirectory();
  final file = File("${appDir.path}/${movie.id}.jpg");

    try {
      await _firestore
          .collection("users")
          .doc(_authService.currentUser!.uid)
          .collection("favoriteMovies")
          .add(movie.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
