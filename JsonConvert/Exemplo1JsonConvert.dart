// Exemplo de Convert Json

import 'dart:convert'; //biblioteca para funcionamento do Json

void main() {
  String dbJson = '''{
            "id":1,
            "nome": "João",
            "login": "joao_user",
            "ativo": true,
            "senha": 1234
                }''';

  Map<String,dynamic> usuario = json.decode(dbJson);

  print(usuario["login"]); //joao_user
  usuario["senha"] = 1111;

  dbJson = json.encode(usuario);

  print(dbJson);

  
}



