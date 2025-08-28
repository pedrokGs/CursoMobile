import 'dart:developer';

import 'package:biblioteca_app/models/book.dart';
import 'package:biblioteca_app/services/api_service.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;

  List<Book> get books => _books;

  bool get isLoading => _isLoading;

  void fetchBooks() async{
    _isLoading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchList("books");
      _books = [];
      for (var book in data) {
        _books.add(Book.fromJson(book));
      }
      _isLoading = false;
    } catch (e) {
      log("Erro $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Book> getBookById(String id) async{
    _isLoading = true;
    notifyListeners();
    try{
      final data = await ApiService.getOne("books", id);
      _isLoading = false;
      notifyListeners();
      return Book.fromJson(data);
    } catch(e){
      log("Erro $e");
      throw Exception("Erro $e");
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    try{
      await ApiService.patch("books", {"isFavorite": isFavorite}, id);
      notifyListeners();
    } catch(e){
      log("Erro $e");
      throw Exception("Erro $e");
    }
  }
}