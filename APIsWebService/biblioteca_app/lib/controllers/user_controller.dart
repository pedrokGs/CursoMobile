import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserController {
  //obs: não precisa instaciar obj de ApiService (métodos static)

  //métodos
  // GET dos Usuários
  Future<List<User>> fetchAll() async{
    final list = await ApiService.fetchList("users?_sort=name"); //?_sort=name -> flag para organizar em order alfabetica
    //retorna a Lista de Usuário Convertidas para User Model List<dynamic> => List<OBJ>
    return list.map<User>((item)=>User.fromJson(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<User> create(User u) async{
    final created  = await ApiService.post("users", u.toJson());
    // adiciona um Usuário e Retorna o Usuário Criado -> ID
    return User.fromJson(created);
  }

  // GET -> Buscar um Usuário
  Future<User> fetchOne(String id) async{
    final user = await ApiService.getOne("users", id);
    // Retorna o Usuário Encontrado no Banco de Dados
    return User.fromJson(user);
  }

  // PUT -> Atualizar Usuário
  Future<User> update(User u, String id) async{
    final updated = await ApiService.put("users", u.toJson(), id);
    //REtorna o Usuário Atualizado
    return User.fromJson(updated);
  }

  Future<void> delete(String id) async{
    await ApiService.delete("users", id);
    // Não há retorno, usuário deletado com sucesso
  }

}