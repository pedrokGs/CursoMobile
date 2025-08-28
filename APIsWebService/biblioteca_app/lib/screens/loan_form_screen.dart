import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:biblioteca_app/models/loan.dart';
import 'package:biblioteca_app/screens/main_screen.dart';
import 'package:biblioteca_app/screens/loan_list_screen.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LoanFormScreen extends StatefulWidget {
  //atributo
  final Loan? loan;

  const LoanFormScreen({super.key, this.loan});

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LoanController();
  final _userIdController = TextEditingController();
  final _bookIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.loan != null){
    _userIdController.text = widget.loan!.userId;
    _bookIdController.text = widget.loan!.bookId;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final loan = Loan(
        bookId: _bookIdController.text,
        userId: _userIdController.text,
        startDate: DateTime.now().toString(),
        dueDate: DateTime.now().add(Duration(days: 30)).toIso8601String(),
        returned: false
      );
      await _controller.create(loan);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(index: 2,),));
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate() && widget.loan != null) {
      final loan = Loan(
        bookId: _bookIdController.text,
        userId: _userIdController.text,
        startDate: DateTime.now().toString(),
        dueDate: DateTime.now().add(Duration(days: 30)).toIso8601String(),
        returned: false
      );
      await _controller.update(loan, widget.loan!.id!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(index: 2,),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.loan == null ? "Novo empréstimo" : "Editar empréstimo",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _userIdController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Usuario"),
              validator:(value) => value!.isEmpty? "Informe o usuario" : null,
            ),
            SizedBox(height: 24,),
            TextFormField(
              controller: _bookIdController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Livro"),
              validator: (value) => value!.isEmpty? "Informe o livro": null,
            ),
            SizedBox(height: 24,),
            ElevatedButton(onPressed: widget.loan == null ? _save : _update, child: Text("Enviar"),)

      ],),
        ),
      ),
    );
  }
}
