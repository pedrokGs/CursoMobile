
// classe TelaConfirmcao

import 'package:flutter/material.dart';

class TelaConfirmacaoView  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmação de Cadastro"),),
      body: Center(
        child: Column(
          children: [
            Text('Cadastro Realizado com Sucesso'),
            SizedBox(height: 24,),
            IconButton(onPressed: () => Navigator.pushNamed(context, '/'), icon: Icon(Icons.home, size: 50,))
          ],
        ),
      ),
    );
  }
}
