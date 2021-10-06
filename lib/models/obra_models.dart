class Obra {
  final String isbn;
  final String titulo;
  final String editora;
  final String autor;
  final String edicao;
  final String dataPubli;
  final String categoria;

  Obra(
      {this.isbn,
      this.titulo,
      this.editora,
      this.autor,
      this.edicao,
      this.dataPubli,
      this.categoria});

  Map<String, dynamic> toMap() {
    return {};
  }

  Obra.fromFirestore(Map<String, dynamic> firestore)
      : isbn = firestore['isbn'],
        titulo = firestore['titulo'],
        editora = firestore['editora'],
        autor = firestore['autor'],
        edicao = firestore['edicao'],
        dataPubli = firestore['dataPubli'],
        categoria = firestore['categoria'];
}
