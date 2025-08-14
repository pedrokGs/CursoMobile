class Tarefa {
  final String id;
  final String titulo;
  bool concluida;

  Tarefa({required this.id, required this.titulo, required this.concluida});

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map["id"],
      titulo: map["titulo"],
      concluida: map["concluida"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "titulo": titulo, "concluida": concluida};
  }
}
