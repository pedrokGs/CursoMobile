class Clima {
  //atributos
  final String cidade;
  final double temperatura;
  final String descricao;

  //construtor
  Clima({
    required this.cidade,
    required this.temperatura,
    required this.descricao
  });

  // toJson e (FromJson)
  //forma diferente de fazer um construtor
  factory Clima.fromJson(Map<String,dynamic> json){
    return Clima(
      cidade: json["name"], // pega o nome da Cidade
      temperatura: json["main"]["temp"].toDouble(), // pega temperatura
      descricao: json["weather"][0]["description"]); // descrição do clima
  }
}