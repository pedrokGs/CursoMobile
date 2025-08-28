import 'package:biblioteca_app/models/loan.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LoanController {
  //obs: não precisa instaciar obj de ApiService (métodos static)

  //métodos
  // GET dos Usuários
  Future<List<Loan>> fetchAll() async{
    final list = await ApiService.fetchList("loans"); //?_sort=name -> flag para organizar em order alfabetica
    //retorna a Lista de Usuário Convertidas para Loan Model List<dynamic> => List<OBJ>
    return list.map<Loan>((item)=>Loan.fromJson(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<Loan> create(Loan u) async{
    final created  = await ApiService.post("loans", u.toJson());
    // adiciona um Usuário e Retorna o Usuário Criado -> ID
    return Loan.fromJson(created);
  }

  // GET -> Buscar um Usuário
  Future<Loan> fetchOne(String id) async{
    final loan = await ApiService.getOne("loans", id);
    // Retorna o Usuário Encontrado no Banco de Dados
    return Loan.fromJson(loan);
  }

  // PUT -> Atualizar Usuário
  Future<Loan> update(Loan u, String id) async{
    final updated = await ApiService.put("loans", u.toJson(), id);
    //REtorna o Usuário Atualizado
    return Loan.fromJson(updated);
  }

  Future<void> delete(String id) async{
    await ApiService.delete("loans", id);
    // Não há retorno, usuário deletado com sucesso
  }

}