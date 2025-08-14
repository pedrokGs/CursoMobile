import 'package:flutter/material.dart';
import 'package:json_path_provider/models/produto.dart';
import 'package:json_path_provider/providers/produto_provider.dart';
import 'package:json_path_provider/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ProdutoScreen extends StatefulWidget {
  const ProdutoScreen({super.key});

  @override
  State<ProdutoScreen> createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  List<Map<String, dynamic>> produtos = [];
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _valorProdutoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final produtoProvider = Provider.of<ProdutoProvider>(context);
    produtoProvider.carregarProdutos();
    produtos = produtoProvider.produtos;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeProdutoController,
              decoration: InputDecoration(labelText: "Nome do Produto"),
            ),
            TextField(
              controller: _valorProdutoController,
              decoration: InputDecoration(labelText: "Valor"),
            ),
            ElevatedButton(
              onPressed: () {
                String nome = _nomeProdutoController.text;
                double? valor = double.tryParse(_valorProdutoController.text);
                Produto produto = Produto(nome: nome, valor: valor!);
                produtoProvider.adicionarProduto(produto);
              },
              child: Text("Enviar"),
            ),
            Divider(),
            Expanded(
              child: produtos.isEmpty
                  ? Center(child: Text("Nenhum produto adicionado"))
                  : ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return ListTile(
                          title: Text(produto["nome"]),
                          subtitle: Text("R\$ ${produto["valor"]}"),
                          trailing: IconButton(
                            onPressed: () => produtoProvider.removerProduto(index),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
