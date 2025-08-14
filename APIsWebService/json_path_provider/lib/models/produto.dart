class Produto {
  final String nome;
  final double valor;

  Produto({required this.nome, required this.valor});

  factory Produto.fromMap(Map<String, dynamic> map){
    return Produto(nome: map["nome"], valor: map["valor"]);
  }

    Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'valor': valor,
    };
  }
}