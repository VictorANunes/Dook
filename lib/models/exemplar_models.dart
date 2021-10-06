import 'dart:convert';

class Exemplar {
  final String status;
  final String descricao;
  final String isbn;
  final String criador;
  final String capa;
  final String lombada;
  final String folhas;
  final String verso;
  final String resp1;
  final String resp2;
  final String resp3;
  final String resp4;
  final String resp5;
  final List<String> listaEspera;

  Exemplar(
      {this.status,
      this.descricao,
      this.isbn,
      this.criador,
      this.capa,
      this.lombada,
      this.folhas,
      this.verso,
      this.resp1,
      this.resp2,
      this.resp3,
      this.resp4,
      this.resp5,
      this.listaEspera});

  Map<String, dynamic> toMap() {
    return {};
  }

  Exemplar.fromFirestore(Map<String, dynamic> firestore)
      : status = firestore['status'],
        descricao = firestore['descricao'],
        isbn = firestore['isbn'],
        criador = firestore['criador'],
        capa = firestore['fotos']['capa'],
        lombada = firestore['fotos']['lombada'],
        folhas = firestore['fotos']['folhas'],
        verso = firestore['fotos']['verso'],
        resp1 = firestore['respostas']['resp1'],
        resp2 = firestore['respostas']['resp2'],
        resp3 = firestore['respostas']['resp3'],
        resp4 = firestore['respostas']['resp4'],
        resp5 = firestore['respostas']['resp5'],
        listaEspera = List.from(firestore['listaEspera']);
}
