import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_shared_preferences/pages/config_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  //atributos
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  void carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString("config");
    if (jsonString != null){
      Map<String, dynamic> config= json.decode(jsonString);

      setState(() {
        temaEscuro = config['temaEscuro'] ?? false;
        nomeUsuario = config['nome'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configuração",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage(temaEscuro: temaEscuro, nomeUsuario: nomeUsuario, onSalvar: (bool novoTema, String novoNome) { 
        setState(() {
          temaEscuro = novoTema;
          nomeUsuario = novoNome;
        });
       },),
    );
  }
}