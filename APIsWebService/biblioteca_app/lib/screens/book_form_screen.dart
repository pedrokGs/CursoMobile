import 'package:biblioteca_app/models/book.dart';
import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/providers/book_provider.dart';
import 'package:biblioteca_app/screens/main_screen.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BookFormScreen extends StatefulWidget {
  //atributo
  final User? user;

  const BookFormScreen({super.key, this.user});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = BookProvider();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _summaryController = TextEditingController();

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        author: _authorController.text,
        available: true,
        imageUrl: _imageUrlController.text,
        summary: _summaryController.text,
        isFavorite: false,
      );
      await _controller.addBook(book);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(index: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Novo Livro"),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Título",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Informe o título" : null,
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Autor",
                ),
                validator: (value) => value!.isEmpty ? "Informe o autor" : null,
              ),
              SizedBox(height: 24,),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Imagem",
                ),
                validator: (value) => value!.isEmpty ? "Informe a imagem" : null,
              ),
              SizedBox(height: 24,),
              TextFormField(
                controller: _summaryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sumário",
                ),
                validator: (value) => value!.isEmpty ? "Informe o sumário" : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _save, child: Text("Enviar")),
            ],
          ),
        ),
      ),
    );
  }
}
