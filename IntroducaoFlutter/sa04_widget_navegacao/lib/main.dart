import 'package:flutter/material.dart';
import 'package:sa04_widget_navegacao/views/tela_cadastro_view.dart';
import 'package:sa04_widget_navegacao/views/tela_confirmacao_view.dart';
import 'package:sa04_widget_navegacao/views/tela_inicial_view.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',

    routes: {
      '/': (context) => TelaInicialView(),
      '/cadastro' :(context) => TelaCadastroView(),
      '/confirmacao' : (context) => TelaConfirmacaoView(),
    },
  ));
}