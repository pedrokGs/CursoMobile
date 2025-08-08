import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  final bool temaEscuro;
  final String nomeUsuario;
  final Function(bool, String) onSalvar;

  const ConfigPage({
    required this.temaEscuro,
    required this.nomeUsuario,
    required this.onSalvar,
    super.key,
  });

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late bool _temaEscuro;
  late TextEditingController _nomeController;

  @override
  void initState() {
    _temaEscuro = widget.temaEscuro;
    _nomeController = TextEditingController(text: widget.nomeUsuario);
    super.initState();
  }

  Future<void> salvarConfiguracoes() async {
    Map<String, dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nome": _nomeController.text.trim(),
    };
    final prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(config);
    prefs.setString("config", jsonString);

    widget.onSalvar(_temaEscuro, _nomeController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferências do Usuário"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _temaEscuro,
              onChanged: (value) {
                setState(() {
                  _temaEscuro = value;
                });
              },
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome do Usuário"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await salvarConfiguracoes();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Preferências atualizadas")),
                );
              },
              child: Text("Salvar"),
            ),

            SizedBox(height: 40),

            Divider(),

            Text(
              "Resumo Atual:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Tema: ${_temaEscuro ? "Escuro" : "Claro"}"),
            Text("Usuário: ${_nomeController.text}"),
          ],
        ),
      ),
    );
  }
}
