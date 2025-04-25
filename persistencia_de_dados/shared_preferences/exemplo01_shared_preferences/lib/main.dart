import 'package:exemplo01_shared_preferences/listaTarefas.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _nomeController = TextEditingController();
  String _nome = "";
  bool _darkMode = true;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString('nome') ?? "";
      _darkMode = _prefs.getBool("darkMode") ?? true;
    });
  }

  void _salvarNome() async {
    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Digite um nome válido")));
    }

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('nome', _nomeController.text);
    _carregarPreferencias();
    _nomeController.clear();
  }

  void _darkModeToggle() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !_darkMode;
    });
    _prefs.setBool("darkMode", _darkMode);
  }

  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo ${_nome.isEmpty ? "Visitante" : _nome}"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _darkModeToggle,

              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Digite seu nome"),
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _salvarNome, child: Text("Salvar")),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListaTarefas()),
                  );
                },
                child: Text("Ver lista de Tarefas"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
