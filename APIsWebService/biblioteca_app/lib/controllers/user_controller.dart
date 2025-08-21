import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserControler {

  //métodos
  // GET dos Usuários
  Future<List<User>> fetchAll() async{
    final list = await ApiService.fetchList("users?_sort=name");
    //retorna a Lista de Usuário Convertidas para User Model
    return list.map<User>((item)=>User.fromJson(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<User> create(User u) async{
    final created  = await ApiService.post("users", u.toJson());
    return User.fromJson(created);
  }

  // GET -> Buscar um Usuário
  Future<User> fetchOne(String id) async{
    final user = await ApiService.getOne("users", id);
    return User.fromJson(user);
  }

  Future<User> update(User u) async{
    final updated = await ApiService.put("users", u.toJson(), u.id!);
    return User.fromJson(updated);
  }
}