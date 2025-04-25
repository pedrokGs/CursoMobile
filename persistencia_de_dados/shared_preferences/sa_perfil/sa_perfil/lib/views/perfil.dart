import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nome = "";
  int idade = 0;
  Color cor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu perfil"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(180),
              ),
              child: Icon(Icons.person, size: 250, color: Colors.blueGrey),
            ),

            SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Text(
                nome.isEmpty ? "Viajante" : nome,
                style: TextStyle(color: Colors.black87, fontSize: 48),
              ),
            ),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Text(
                "Idade:  ${idade == 0 ? "Desconhecida" : idade}",
                style: TextStyle(color: Colors.black87, fontSize: 48),
              ),
            ),
                        SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Cor Preferida:"),
                  SizedBox(height: 24,),
                  ElevatedButton(onPressed: () {
                    
                  }, child: Text("Escolher uma cor"))
                ],
              )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
