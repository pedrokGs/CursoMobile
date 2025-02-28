import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Estudo do scaffold
      home: Scaffold(
        // Barra de navegação superior
        appBar: AppBar(
          title: Text("Exemplo AppBar"),
          backgroundColor: Colors.blue,
        ),
        // Corpo do aplicativo
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person),
                Icon(Icons.zoom_out),
                Icon(Icons.add),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.book),
                Icon(Icons.person),
                Icon(Icons.apple),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.money),
                Icon(Icons.terrain),
                Icon(Icons.person),
              ],
            ),
          ],
        ),
        // Barra lateral (Menu hamburguer)
        drawer: Drawer(
          child: ListView(
            children: [Text("Início"), Text("Conteúdo"), Text("Contato")],
          ),
        ),
        // Barra de navegação inferior
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Pesquisa",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuário"),
          ],
        ),
        // Botão flutuante
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Botão Clicado");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
