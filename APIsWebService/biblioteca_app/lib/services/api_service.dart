import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // base URL para Conexão com API
  static const String _baseURL = "http://10.109.197.8:3003";

  static Future<List<dynamic>> fetchList(String path) async{
    final res = await http.get(Uri.parse("$_baseURL/$path"));

    if(res.statusCode == 200){
      final data = jsonDecode(res.body);
      return data;
    } else{
      throw Exception("Falha ao carregar a lista de $path");
    }
  }

  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseURL/$path:$id"));
    if (res.statusCode ==200) return json.decode(res.body);
    // se não der certo
   throw Exception("Falha ao Carregar item de $path");
  }

static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(
      Uri.parse("$_baseURL/$path"),
      headers: {"Content-Type": "applciation/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Criar em $path");
  }

  //PUT (Atualizar Recurso)
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String id) async{
    final res = await http.put(
      Uri.parse("$_baseURL/$path/$id"),
      headers: {"Content-Type": "applciation/json"},
      body: json.encode(body)
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Atualizar em $path");
  }

  //DELETE (Apagar Recurso)
  static delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseURL/$path/$id"));
    if ( res.statusCode != 200) throw Exception("Falha ao Deletar de $path");
  }

}