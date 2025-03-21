import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ListaTarefas()));
}

class ListaTarefas extends StatefulWidget {
  // Chamar as mudanças de estrutura
  @override
  _listaTarefasState createState() => _listaTarefasState();
}

class _listaTarefasState extends State<ListaTarefas> {
  // Classe construtora
  final TextEditingController _tarefaController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: 'Digite uma tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: Text('Adicionar Tarefa'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder:
                    (context, index) => ListTile(
                      leading: Checkbox(
                        value: _tarefas[index]['concluida'],
                        onChanged:
                            (bool? valor) => setState(() {
                              _tarefas[index]['concluida'] = valor!;
                            }),
                      ),
                      title: Text(
                        _tarefas[index]['titulo'],
                        style: TextStyle(
                          decoration:
                              _tarefas[index]['concluida']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _removerTarefasConcluidas, child: Icon(Icons.cancel),),
    );
  }

  void _removerTarefasConcluidas(){
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa['concluida']);
    });
  }

  void _adicionarTarefa() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add({
          "titulo": _tarefaController.text.trim(),
          'concluida': false,
        });
        _tarefaController.clear();
      });
    }
  }
}
