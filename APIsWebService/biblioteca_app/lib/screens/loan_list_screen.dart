import 'package:biblioteca_app/controllers/loan_controller.dart';
import 'package:biblioteca_app/models/loan.dart';
import 'package:biblioteca_app/screens/loan_form_screen.dart';
import 'package:flutter/material.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  final _controller = LoanController();
  List<Loan> _loans = [];
  bool _loading = true;
  List<Loan> _filteredLoans = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load(); //carregar as informações iniciais de users
  }

  void _load() async{
    setState(() => _loading = true);
    try {
      _loans = await _controller.fetchAll();
      _filteredLoans = _loans;
    } catch (e) {
      //tratar erro aqui
    }
    setState(() => _loading = false);
  }

  //método para criar uma lista de usuário filtrada pelas letras que forem 
  // digitas na barra de pesquisa
  void _loansFilter(){
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLoans = _loans.where((loan){
        return loan.bookId.toLowerCase().contains(query) || 
        loan.userId.toLowerCase().contains(query);
      }).toList();
    });
  }

  //build da Tela
  @override
  Widget build(BuildContext context) {
return Scaffold(
      //não precisa de Appbar -> já tem a appbar da homeView
      body: _loading
      ? Center(child: CircularProgressIndicator(),)
      : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Pesquisar Empréstimo", 
                border: OutlineInputBorder()),
                onChanged: (value) => _loansFilter() ,
            ),
            Expanded(
              child:ListView.builder(
                itemCount: _filteredLoans.length,
                itemBuilder: (context,index){
                  final loan = _filteredLoans[index];
                  return Card(
                    child: ListTile(
                      title: Text(loan.bookId),
                      subtitle: Text(loan.userId),
                      trailing: IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoanFormScreen(loan: loan,),));
                      }, icon: Icon(Icons.edit), tooltip: "Editar",),
                    ),
                  );
                }) ),
          ],
        ),),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoanFormScreen(),));
        }, child: Icon(Icons.add),),
    );
}}