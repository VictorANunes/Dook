class Book {
  String isbn;
  String titulo;
  String editora;
  String autor;
  String edicao;
  String dataPubli;
  String categoria;

  Book(
      {this.isbn,
      this.titulo,
      this.editora,
      this.autor,
      this.edicao,
      this.dataPubli,
      this.categoria});

  factory Book.fromJson(Map<String, dynamic> jsonBook) {
    var autores = jsonBook['items'][0]['volumeInfo']['authors'];
    autores = autores.toString();
    autores = autores.replaceAll('[', '').replaceAll(']', '');

    return Book(
      isbn: jsonBook['items'][0]['volumeInfo']['industryIdentifiers'][1]
          ['identifier'],
      titulo: jsonBook['items'][0]['volumeInfo']['title'],
      editora: jsonBook['items'][0]['volumeInfo']['publisher'],
      autor: autores,
      edicao: jsonBook['items'][0]['volumeInfo']['edition'],
      dataPubli: jsonBook['items'][0]['volumeInfo']['publishedDate'],
      categoria: null,
    );
  }
}
