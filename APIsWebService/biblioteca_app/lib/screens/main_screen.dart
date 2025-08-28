import 'package:biblioteca_app/screens/home_screen.dart';
import 'package:biblioteca_app/screens/loan_list_screen.dart';
import 'package:biblioteca_app/screens/user_list_screen.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  int index = 0;
  MainScreen({super.key, this.index = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const LoanListScreen(),
    const UserListScreen(),
  ];

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(()=> _index = value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Livros"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Empréstimos"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Usuários"),
        ]),
    );
  }
}