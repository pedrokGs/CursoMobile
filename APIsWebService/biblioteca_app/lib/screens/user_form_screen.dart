import 'package:biblioteca_app/controllers/user_controller.dart';
import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/screens/main_screen.dart';
import 'package:biblioteca_app/screens/user_list_screen.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class UserFormScreen extends StatefulWidget {
  //atributo
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = UserController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null){
    _nameController.text = widget.user!.name;
    _emailController.text = widget.user!.email;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
      );
      await _controller.create(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(index: 2,),));
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate() && widget.user != null) {
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
      );
      await _controller.update(user, widget.user!.id!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(index: 2,),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.user == null ? "Novo usuário" : "Editar usuário",
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Nome"),
              validator:(value) => value!.isEmpty? "Informe o nome" : null,
            ),
            SizedBox(height: 24,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
              validator: (value) => value!.isEmpty? "Informe o email": null,
            ),
            SizedBox(height: 24,),
            ElevatedButton(onPressed: widget.user == null ? _save : _update, child: Text("Enviar"),)

      ],),
        ),
      ),
    );
  }
}
