import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaInicialView extends StatelessWidget {
  const TelaInicialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bem Vindo!"),
      centerTitle: true,),

      body: Center(
        child: Column(
          children: [
            Text('Olá Visitante, Seja Bem Vindo ao nosso app', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () =>  Navigator.pushNamed(context, '/cadastro'), child: Text('Cadastro'))
          ],
        ),
      ),
    );
  }
}