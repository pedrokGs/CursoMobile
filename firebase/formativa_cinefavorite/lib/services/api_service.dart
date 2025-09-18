import 'dart:convert';

import 'package:formativa_cinefavorite/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = "a79ede5d352ac071ddcb209572b9a0d9";
  static const String _baseUrl = "https://api.themoviedb.org/3";

  static Future<List<Movie>> searchMovies(String query) async {
    try{
      final uri = Uri.parse('$_baseUrl/search/movies?api_key=$_apiKey&query=$query');
      final response = await http.get(uri);

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final List<Movie> movies = [];
        for (var movie in data['results']) {
          movies.add(Movie.fromMap(movie));
        }
        return movies;
      } else{
        throw Exception("Request was not successful. Status code: ${response.statusCode}");
      }
    }catch(e){
      rethrow;
    }
  }

  static Future<List<Movie>> getPopular() async{
    try{
      final uri = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-br');
      final response = await http.get(uri);

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final List<Movie> movies = [];
        for(var movie in data['results']){
          movies.add(Movie.fromMap(movie));
        }
        return movies;
      } else{
        throw Exception("Request was not successful. Status code: ${response.statusCode}");
      }
    } catch(e){
      rethrow;
    }
  }

}