import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key});

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  List<String> _tarefas = [];
  bool _darkMode = true;
  String _nome = "";
  TextEditingController _tarefaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('darkMode') ?? false;
      _nome = _prefs.getString('nome') ?? "";
      _tarefas = _prefs.getStringList('tarefas') ?? [];
    });
  }

  void _adicionarTarefas() async {
    if (_tarefaController.text.trim().isNotEmpty) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      setState(() {
        _tarefas.add(_tarefaController.text);
        _prefs.setStringList('tarefas', _tarefas);
        _tarefaController.clear();
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Escreva um texto válido")));
    }
  }

  void _removerTarefas(int index) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _tarefas.removeAt(index);
      _prefs.setStringList('tarefas', _tarefas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas de ${_nome.isEmpty ? 'Visitante' : _nome}",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _tarefaController,
                decoration: InputDecoration(
                  label: Text('Digite uma tarefa'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _adicionarTarefas,
                child: Text("Enviar tarefa"),
              ),
              SizedBox(height: 16,),
              Expanded(child: ListView.builder(
                itemCount: _tarefas.length, itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tarefas[index]),
                  trailing: IconButton(onPressed:() => _removerTarefas(index), icon: Icon(Icons.delete)),
                );
              },))
            ],
          ),
        ),
      ),
    );
  }
}
