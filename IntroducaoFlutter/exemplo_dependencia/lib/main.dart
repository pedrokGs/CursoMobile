import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){ // Método principal para rodar a aplicação
    runApp(MyApp()); // Construtor da classe principal
}

class MyApp extends StatelessWidget{ // Classe principal
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp - Contém os widgets Android
        home: Center(
          child: Scaffold( // Tela de visualização básica
              appBar: AppBar(title: Text("Exemplo App Dependência"),),
              body: ElevatedButton(onPressed: () {
                  Fluttertoast.showToast(msg: "Olá mundo", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
              }, child: Text("Clique aqui")),
          ),
        ),
    );
  }
}