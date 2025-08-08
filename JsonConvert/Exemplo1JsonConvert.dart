// Exemplo de Convert Json

import 'dart:convert'; //biblioteca para funcionamento do Json

void main() {
  // Texto em formato json
  String dbJson = '''{
            "id":1,
            "nome": "João",
            "login": "joao_user",
            "ativo": true,
            "senha": 1234
                }''';

  // Convertendo Texto Json -> Map Dart
  Map<String,dynamic> usuario = json.decode(dbJson);

  // Mudar a senha do usuario p/ 1111
  print(usuario["login"]); //joao_user
  usuario["senha"] = 1111;

  // Fazer o encode -> Map Dart -> Texto Json

  dbJson = json.encode(usuario);

  print(dbJson);

  
}



