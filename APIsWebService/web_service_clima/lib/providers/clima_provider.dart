import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_service_clima/models/clima.dart';
import 'package:web_service_clima/services/clima_service.dart';

class ClimaProvider extends ChangeNotifier{
    final _climaService = ClimaService();
    Clima? climaAtual;
    String? erroAtual;

    Clima? get clima => climaAtual;
    String? get erro => erroAtual;

    void buscarCidade(String? cidade) async {
    if (cidade == null || cidade.isEmpty) {
      log("Cidade não pode ser nula ou vazia.");
      return;
    }
    try {
      climaAtual = await _climaService.fetchClima(
        cidade
      );
      notifyListeners();

      }catch (e) {
      print("Erro ao estabelecer Conexão: $e");
      throw Exception("Error: $e");
    }
  }
}