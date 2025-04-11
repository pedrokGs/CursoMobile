import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroView extends StatefulWidget {
  const TelaCadastroView({super.key});

  @override
  State<TelaCadastroView> createState() => _TelaCadastroViewState();
}

class _TelaCadastroViewState extends State<TelaCadastroView> {
  String _nome = "";
  String _email = "";
  double _idade = 13;
  bool _aceiteTermos = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Digite o Nome"),
                validator: (value) => value!.isEmpty ? "Insira um Nome" : null,
                onSaved: (value) => _nome = value!,
              ),

              
              TextFormField(
                decoration: InputDecoration(labelText: "Digite um Email"),
                validator: (value) => value!.contains('@') ? null : "Insira um email válido",
                onSaved: (value) => _email = value!,
              ),

              SizedBox(height: 20,),

              Text('Informe a Idade'),
              Slider(value: _idade, min:13, max:99, divisions: 86, label:_idade.round().toString(), onChanged: (value)=> setState(() {
                _idade = value;
              }),),
              CheckboxListTile(value: _aceiteTermos,title: Text("Aceito os termos de Uso"),onChanged: (value) => setState(() {
                _aceiteTermos = value!;
              }),),
              ElevatedButton(onPressed: _enviarDados, child: Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }

  void _enviarDados() {
    if (_formKey.currentState!.validate() && _aceiteTermos) {
      _formKey.currentState!.save(); 
      Navigator.pushNamed(context, '/confirmacao');
    }
  }
}