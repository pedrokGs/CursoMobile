import 'package:flutter/material.dart';
import 'package:formativa_cinefavorite/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Cinefavorite"), actions: [
      IconButton(onPressed: () {
        _authService.logout();
      }, icon: Icon(Icons.logout))
    ],),);
  }
}