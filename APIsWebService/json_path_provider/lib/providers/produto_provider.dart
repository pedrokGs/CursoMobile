import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:json_path_provider/models/produto.dart';
import 'package:path_provider/path_provider.dart';

class ProdutoProvider extends ChangeNotifier{
  List<Map<String,dynamic>> _list = [{"nome": "Teste", "valor": 14.99}];

  List<Map<String, dynamic>> get produtos => (_list);

  Future<File> _getFile () async{
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/produtos.json");
  }

  Future<void> carregarProdutos() async{
    try {
      final file = await _getFile();
      String conteudo = await file.readAsString();
        final decoded = json.decode(conteudo);
        if (decoded is List) {
          _list = List<Map<String, dynamic>>.from(decoded);
        }
    } catch (e) {
      _list = [];
      log('Error loading products: $e');  
    }
    notifyListeners();
  }

  Future<void> _salvarProdutos() async {
    try{
      final file = await _getFile();
      String jsonProdutos = json.encode(_list);
      await file.writeAsString(jsonProdutos);
      carregarProdutos();
    } catch (e) {
      log('Error loading products: $e');  
    }
    notifyListeners();
  }

  Future<void> adicionarProduto(Produto produto) async{
    Map<String, dynamic> jsonProduto = produto.toMap();
    _list.add(jsonProduto);
    _salvarProdutos();
  }

  Future<void> removerProduto(int index) async{
    _list.removeAt(index);
    _salvarProdutos();
  }
}