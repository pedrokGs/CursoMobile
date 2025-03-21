import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaCadastro()));
}

class TelaCadastro extends StatefulWidget {
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  String nome = "";
  String email = "";
  String senha = "";
  String genero = "";
  String dataNascimento = "";
  double _experiencia = 0;
  bool _termos = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadstro de Usuário")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ),
                validator: (value) => value!.isEmpty ? 'Digite seu nome' : null,
                onSaved: (value) => nome = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator:
                    (value) =>
                        value!.contains("@") ? null : 'Digite um email válido',
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                ),
                validator:
                    (value) =>
                        value!.length < 6
                            ? 'A senha deve ter no mínimo 6 caractéres'
                            : null,
                onSaved: (value) => senha = value!,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Gênero",
                ),
                items:
                    ["Masculino", "Feminino"].map((String genero) {
                      return DropdownMenuItem(
                        value: genero,
                        child: Text(genero),
                      );
                    }).toList(),
                onChanged: (value) {},
                validator:
                    (value) => value == null ? "Selecione um gênero" : null,
                onSaved: (value) => genero = value!,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Data de Nascimento",
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? "Digite a data de nascimento" : null,
                onSaved: (value) => dataNascimento = value!,
              ),
              SizedBox(height: 10),
              Slider(
                value: _experiencia,
                min: 0,
                max: 20,
                divisions: 20,
                label: _experiencia.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _experiencia = value;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                value: _termos,
                title: Text("Aceito os termos de uso"),
                onChanged:
                    (value) => setState(() {
                      _termos = value!;
                    }),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: Text("Cadastrar", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _termos) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Dados do formulário:"),
              content: Column(
                children: [Text("Nome: $nome"), Text("Email: $email")],
              ),
            ),
      );
    }
  }
}
