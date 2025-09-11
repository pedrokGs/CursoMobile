import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  bool get isDark => _currentTheme == ThemeMode.dark;

  void toggleTheme(){
    _currentTheme == ThemeMode.dark ? _currentTheme = ThemeMode.light : _currentTheme = ThemeMode.dark;
    notifyListeners();
  }
}