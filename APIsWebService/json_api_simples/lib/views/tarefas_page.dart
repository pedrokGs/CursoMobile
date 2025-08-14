import 'package:flutter/material.dart';
import 'package:json_api_simples/models/tarefa.dart';
import 'package:json_api_simples/providers/theme_provider.dart';
import 'package:json_api_simples/services/tarefa_service.dart';
import 'package:provider/provider.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final _tarefaService = TarefaService();
  late List<Tarefa> tarefas;
  bool _isLoading = true;
  final TextEditingController _tarefaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTarefas();
  }

  void loadTarefas() async {
    setState(() {
      _isLoading = true;
    });
    tarefas = await _tarefaService.fetchTarefas();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas API"),
        actions: [
          IconButton(
            onPressed: () {
              if (_themeProvider.themeMode == ThemeMode.dark) {
                _themeProvider.toggleTheme(false);
              } else {
                _themeProvider.toggleTheme(true);
              }
            },
            icon: Icon(
              _themeProvider.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(
                      labelText: "Nova tarefa",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 24),

                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_tarefaController.text.trim().isNotEmpty) {
                          _tarefaService.adicionarTarefa(
                            _tarefaController.text,
                          );
                          loadTarefas();
                          _tarefaController.text = "";
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      child: Text(
                        "Adicionar",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  Divider(),
                  Expanded(
                    //operador ternário
                    child: tarefas.isEmpty
                        ? Center(child: Text("Nenhuma Tarefa"))
                        : ListView.builder(
                            itemCount: tarefas.length,
                            itemBuilder: (_, index) {
                              final tarefa = tarefas[index];
                              return ListTile(
                                title: Text(tarefa.titulo),
                                subtitle: Text(
                                  tarefa.concluida ? "Concluída" : "Pendente",
                                ),
                                leading: Checkbox(
                                  value: tarefa.concluida,
                                  onChanged: (value) {
                                    setState(() {
                                      tarefa.concluida = value!;
                                    });
                                    _tarefaService.atualizarTarefa(tarefa);
                                  },
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    _tarefaService.removerTarefa(tarefa.id);
                                    loadTarefas();
                                  },
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
