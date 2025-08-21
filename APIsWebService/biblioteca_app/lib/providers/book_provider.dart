import 'dart:developer';

import 'package:biblioteca_app/models/book.dart';
import 'package:biblioteca_app/services/api_service.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  final List<Book> _books = [];
  bool _isLoading = false;

  List<Book> get books => _books;

  bool get isLoading => _isLoading;

  void fetchBooks() async{
    _isLoading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchList("books");
      for (var book in data) {
        _books.add(Book.fromJson(book));
      }
      _isLoading = false;
    } catch (e) {
      log("Erro");
    }
    _isLoading = false;
    notifyListeners();
  }
}