import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() { // Roda minha aplicação
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { // Janela de Aplicação
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Base de construção
      home: Scaffold( // Modelo de página
        appBar: AppBar(title: Text("App Hello World")),
        body: Center(
          child: ElevatedButton(onPressed: () => Fluttertoast.showToast(
            msg: "Hello, World!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER
          )
          , child: Text("Ver mensagem")
          ),
        ),
      ),
    );
  }
}
