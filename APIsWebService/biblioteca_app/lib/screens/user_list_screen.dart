import 'package:biblioteca_app/controllers/user_controller.dart';
import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/screens/user_form_screen.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  //atributos
  final _controller = UserController();
  List<User> _users = [];
  bool _loading = true;
  List<User> _filteredUsers = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load(); //carregar as informações iniciais de users
  }

  void _load() async{
    setState(() => _loading = true);
    try {
      _users = await _controller.fetchAll();
      _filteredUsers = _users;
    } catch (e) {
      //tratar erro aqui
    }
    setState(() => _loading = false);
  }

  //método para criar uma lista de usuário filtrada pelas letras que forem 
  // digitas na barra de pesquisa
  void _usersFilter(){
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user){
        return user.name.toLowerCase().contains(query) || 
        user.email.toLowerCase().contains(query);
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
                labelText: "Pesquisar Usuário", 
                border: OutlineInputBorder()),
                onChanged: (value) => _usersFilter() ,
            ),
            Expanded(
              child:ListView.builder(
                itemCount: _filteredUsers.length,
                itemBuilder: (context,index){
                  final user = _filteredUsers[index];
                  return Card(
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserFormScreen(user: user,),));
                      }, icon: Icon(Icons.edit), tooltip: "Editar",),
                      //trailing
                    ),
                  );
                }) ),
          ],
        ),),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserFormScreen(),));
        }, child: Icon(Icons.add),),
    );
    
  }
}
