class Nota{
  //atributos
  final int? id; // permite seja nula 
  final String titulo;
  final String conteudo;

  Nota({this.id, required this.titulo, required this.conteudo});

  Map<String,dynamic> toMap(){
    return{
      "id":id,
      "titulo":titulo,
      "conteudo":conteudo
    };
  }

  //Converte um Map( vindo do Banco de Dados) => Objeto da Classe Nota
  factory Nota.fromMap(Map<String,dynamic> map){
    return Nota(
      id: map["id"],
      titulo: map["titulo"] as String,
      conteudo: map["conteudo"] as String
    );
  }

  //método para imprimir os dados 
  @override
  String toString() {
    return 'Nota{id: $id, título: $titulo, conteudo: $conteudo}';
  }

}