import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:json_api_simples/models/tarefa.dart';

class TarefaService {
  final String baseUrl = "http://10.109.197.5:3003/tarefas";

  Future<List<Tarefa>> fetchTarefas() async {
    final response = await http.get(
        Uri.parse(baseUrl)
    );

    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Tarefa.fromMap(json)).toList();
    }

    else {
      throw Exception("Failed to load tarefas");
    }
  }

  void removerTarefa(String id) async {
    try {
      //solicita http delete
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        log("Tarefa removida");
      }
    } catch (e) {
      log("Erro ao Deletar Tarefa $e");
    }
  }

  void adicionarTarefa(String titulo) async {
    try {
      final tarefa = {"titulo": titulo, "concluida": false};
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-type": "application/json"},
        body: json.encode(tarefa),
      );
    } catch (e) {
      log("Erro ao adicionar tarefa $e");
    }
  }

  Future<void> atualizarTarefa(Tarefa tarefa) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/${tarefa.id}"),
      headers: {"Content-type": "application/json"},
      body: json.encode(tarefa.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update tarefa");
    }
  }
}
