import 'dart:developer';

import 'package:biblioteca_app/models/book.dart';
import 'package:biblioteca_app/services/api_service.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _availableBooks = [];
  bool _isLoading = false;

  List<Book> get books => _books;

  List<Book> get availableBooks => _availableBooks;

  bool get isLoading => _isLoading;

  void fetchBooks() async{
    _isLoading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchList("books");
      _books = [];
      _availableBooks = [];
      for (var book in data) {
        Book newBook = Book.fromJson(book);
        print(newBook.available);
        _books.add(newBook);
        if(newBook.available){
          _availableBooks.add(newBook);
        }
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

  Future<void> addBook(Book book) async{
    try{
     await ApiService.post('books', book.toJson());
     notifyListeners(); 
    } catch(e){
      throw Exception("Erro $e");
    }
  }

  Future<void> deleteBook(String id) async{
    try{
      await ApiService.delete("books", id);
      notifyListeners();
    } catch(e){
      throw Exception("Erro $e");
    }
  }
}