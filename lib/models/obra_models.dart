class Obra {
  final String isbn;
  final String titulo;
  final String editora;
  final String autor;
  final String edicao;
  final String dataPubli;
  final List<String> categoria;

  Obra(
      {this.isbn,
      this.titulo,
      this.editora,
      this.autor,
      this.edicao,
      this.dataPubli,
      this.categoria});

  Map<String, dynamic> toMap(List<String> pesqList) {
    return {
      'titulo': titulo,
      'editora': editora,
      'autor': autor,
      'dataPubli': dataPubli,
      'edicao': edicao,
      'categoria': categoria,
      'pesqList': pesqList
    };
  }

  Obra.fromFirestore(Map<String, dynamic> firestore)
      : isbn = firestore['isbn'],
        titulo = firestore['titulo'],
        editora = firestore['editora'],
        autor = firestore['autor'],
        edicao = firestore['edicao'],
        dataPubli = firestore['dataPubli'],
        categoria = List.from(firestore['categoria']);
}
