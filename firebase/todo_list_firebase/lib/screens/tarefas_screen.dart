import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_firebase/providers/theme_provider.dart';
import 'package:todo_list_firebase/services/auth_service.dart';
import 'package:todo_list_firebase/services/firestore_service.dart';

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  final _auth = AuthService();
  final _firestore = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;
  final _tarefasField = TextEditingController();

  // método para adicionar tarefa
  void _addTarefa() async {
    if (_tarefasField.text.trim().isEmpty && _user == null) return;
    try {
      await _firestore.addTarefa(_tarefasField.text.trim());
      _tarefasField.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao adicionar tarefa")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
        actions: [
          IconButton(
            onPressed: () => _themeProvider.toggleTheme(),
            icon: Icon(
              _themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
          IconButton(onPressed: _auth.logout, icon: Icon(Icons.logout)),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefasField,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nova Tarefa",
                suffix: IconButton(
                  onPressed: () {
                    _showAddingPopup(context);
                  },
                  icon: Icon(Icons.send),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.fetchTarefasForUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhuma tarefa encontrada"));
                  }
                  final tarefas = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];
                      final tarefaData = tarefa.data() as Map<String, dynamic>;
                      bool concluida = tarefaData["concluida"] ?? false;

                      return ListTile(
                        title: Text(tarefaData["titulo"]),
                        leading: Checkbox(
                          value: concluida,
                          onChanged: (value) {
                            setState(() {
                              concluida = !concluida;
                            });
                            _firestore.updateTarefaStatus(tarefa.id, concluida);
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () => _showDeletingPopup(context, tarefa.id),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeletingPopup(BuildContext context, String tarefaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Você tem certeza que quer deletar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _firestore.deleteTarefa(tarefaId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deletando...')),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
}
  void _showAddingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar adição'),
          content: const Text('Você tem certeza que quer adicionar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addTarefa();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Adicionando...')),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
}


}