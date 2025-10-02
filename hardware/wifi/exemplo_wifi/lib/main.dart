import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WifiStatusScreen());
  }
}

class WifiStatusScreen extends StatefulWidget {
  const WifiStatusScreen({super.key});

  @override
  State<WifiStatusScreen> createState() => _WifiStatusScreenState();
}

class _WifiStatusScreenState extends State<WifiStatusScreen> {
  String _mensagem = "";
  late StreamSubscription<List<ConnectivityResult>> _conexaoSubscription;

  @override
  void dispose() {
    super.dispose();
    _conexaoSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _checkInicialConnection();

    _conexaoSubscription = 
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Pega o primeiro resultado disponível, ou ConnectivityResult.none se a lista estiver vazia
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateConexaoStatus(result);
    });
  }

  void _checkInicialConnection() async{
    ConnectivityResult connectivityResult = (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConexaoStatus(connectivityResult);
  }

  void _updateConexaoStatus(ConnectivityResult result) async {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _mensagem = "Conectado pelo Wifi";
          break;

        case ConnectivityResult.mobile:
          _mensagem = "Conectado pelos Dados Móveis";
          break;

        case ConnectivityResult.none:
          _mensagem = "Sem conexão com a Internet";
          break;
        
        default:
          _mensagem = "Conexão desconhecida";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(title: Text("Status da Conexão"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              //mudar de Acordo com o Resultado do Status
              _mensagem.contains("WIFI") ? Icons.wifi :
              _mensagem.contains("Dados") ? Icons.network_cell :
              Icons.wifi_off,
              size: 80,
              color: _mensagem.contains("Sem Conexão") ? Colors.red : Colors.green, 
            ),
                        SizedBox(height: 10,),
            Text("Status: $_mensagem")
          ],
        ),
      )
    );
  }
}
