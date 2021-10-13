import 'dart:convert';

class Exemplar {
  final String status;
  final String isbn;
  final String criador;
  final String capa;
  final String contracapa;
  final String lombada;
  final String corteSuperior;
  final String corteDianteiro;
  final String corteInferior;
  final String resp1;
  final String resp2;
  final String resp3;
  final String resp4;
  final String resp5;
  final List<String> listaEspera;

  Exemplar(
      {this.status,
      this.isbn,
      this.criador,
      this.capa,
      this.contracapa,
      this.lombada,
      this.corteSuperior,
      this.corteDianteiro,
      this.corteInferior,
      this.resp1,
      this.resp2,
      this.resp3,
      this.resp4,
      this.resp5,
      this.listaEspera});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'isbn': isbn,
      'criador': criador,
      'fotos': {
        'capa': capa,
        'contracapa': contracapa,
        'lombada': lombada,
        'cortesuperior': corteSuperior,
        'cortedianteiro': corteDianteiro,
        'corteinferior': corteInferior
      },
      'respostas': {
        'resp1': resp1,
        'resp2': resp2,
        'resp3': resp3,
        'resp4': resp4,
        'resp5': resp5
      },
      'listaEspera': []
    };
  }

  Exemplar.fromFirestore(Map<String, dynamic> firestore)
      : status = firestore['status'],
        isbn = firestore['isbn'],
        criador = firestore['criador'],
        capa = firestore['fotos']['capa'],
        contracapa = firestore['fotos']['contracapa'],
        lombada = firestore['fotos']['lombada'],
        corteSuperior = firestore['fotos']['cortesuperior'],
        corteDianteiro = firestore['fotos']['cortedianteiro'],
        corteInferior = firestore['fotos']['corteinferior'],
        resp1 = firestore['respostas']['resp1'],
        resp2 = firestore['respostas']['resp2'],
        resp3 = firestore['respostas']['resp3'],
        resp4 = firestore['respostas']['resp4'],
        resp5 = firestore['respostas']['resp5'],
        listaEspera = List.from(firestore['listaEspera']);
}
