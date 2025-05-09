import 'package:exemplo_sqlite/connection/nota_dbhelper.dart';
import 'package:exemplo_sqlite/model/nota_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotaDBHelper _dbHelper = NotaDBHelper();
  List<Nota> _notas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotas();
  }

  Future<void> _loadNotas() async {
    setState(() {
      _isLoading = true;
    });
    _notas = [];
    _notas = await _dbHelper.getNotas();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addNotas() async {
    Nota novaNota = Nota(
      titulo: "Nota ${DateTime.now()}",
      conteudo: "Conteúdo da Nota",
    );
    await _dbHelper.create(novaNota);
    _loadNotas();
  }

  void _deleteNota(int id) async {
    await _dbHelper.deleteNota(id);
    _loadNotas();
  }

  void _updateNota(Nota nota) async {
    showDialog(
      context: context,
      builder: (context) {
      TextEditingController tituloController = TextEditingController(text: nota.titulo);
      TextEditingController conteudoController = TextEditingController(text: nota.conteudo);

      return AlertDialog(
        title: Text("Editar Nota"),
        content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
          controller: tituloController,
          decoration: InputDecoration(labelText: "Título"),
          ),
          TextField(
          controller: conteudoController,
          decoration: InputDecoration(labelText: "Conteúdo"),
          ),
        ],
        ),
        actions: [
        TextButton(
          onPressed: () {
          Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () async {
          Nota notaAtualizada = Nota(
            id: nota.id,
            titulo: tituloController.text,
            conteudo: conteudoController.text,
          );
          await _dbHelper.updateNota(notaAtualizada);
          _loadNotas();
          Navigator.of(context).pop();
          },
          child: Text("Salvar"),
        ),
        ],
      );
      },
    );

    Nota notaAtualizada = Nota(
      id: nota.id,
      titulo: "${nota.titulo} (editado)",
      conteudo: nota.conteudo,
    );
    await _dbHelper.updateNota(notaAtualizada);
    _loadNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        bottomOpacity: 1,
        title: Text("SQFLITE"),
        backgroundColor: const Color.fromARGB(179, 255, 193, 152),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            _dbHelper.clearNotes();
          }, icon: Icon(Icons.clear))
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _notas.length,
                itemBuilder: (context, index) {
                  final nota = _notas[index];
                  return ListTile(
                    title: Text(nota.titulo),
                    subtitle: Text(nota.conteudo),
                    leading: Text(nota.id.toString()),
                    trailing: IconButton(
                      onPressed: () => _deleteNota(nota.id!),
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                    ),
                    onTap: () => _updateNota(nota),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNotas(),
        tooltip: 'Adicionar Nota',
        child: Icon(Icons.add),
      ),
    );
  }
}
