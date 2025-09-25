import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:formativa_cinefavorite/screens/search_movie_screen.dart';
import 'package:formativa_cinefavorite/services/auth_service.dart';
import 'package:formativa_cinefavorite/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = AuthService();
  final movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cinefavorite"),
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<Movie>>(
        stream: movieService.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar dados"));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum filme favoritado"));
          }

          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () => showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: Text("Remover dos Favoritos"),
                            content: Text("Deseja remover ${movie.title} dos favoritos?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context), 
                                child: Text("Cancelar")),
                              TextButton(
                                onPressed: () async{
                                  movieService.removeFavoriteMovie(movie.id);
                                  Navigator.pop(context);
                                }, 
                                child: Text("Remover"))
                            ],
                          )),
                        child: Image.file(
                          File(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(movie.title),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Nota: ${movie.rating.toStringAsFixed(2)}"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchMovieScreen()),
          );
        },
      ),
    );
  }
}
