import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:formativa_cinefavorite/services/api_service.dart';
import 'package:formativa_cinefavorite/services/movie_service.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final _movieService = MovieService();
  final _searchController = TextEditingController();

  List<Movie> _searchResults = [];
  bool _isLoading = false;

  void _searchMovies() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final resultado = await ApiService.searchMovies(query);
      _searchResults = resultado;
    } catch (e) {
      _searchResults = [];
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao buscar filmes: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Filme")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Procurar",
                suffix: IconButton(
                  onPressed: () {
                    _searchMovies();
                  },
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12.0),

            _isLoading
                ? CircularProgressIndicator()
                : _searchResults.isEmpty
                ? Text("Nenhum filme encontrado")
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = _searchResults[index];
                        return ListTile(
                          title: Text(movie.title),
                          trailing: IconButton(
                            onPressed: () async {
                               _movieService.addMovieToFavorites(movie);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${movie.title} adicionado aos favoritos",
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.favorite),
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
