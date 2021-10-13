import 'package:dook/models/exemplar_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ExemplarProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _status;
  String _isbn;
  String _criador;
  String _capa;
  String _contracapa;
  String _lombada;
  String _corteSuperior;
  String _corteDianteiro;
  String _corteInferior;
  String _resp1;
  String _resp2;
  String _resp3;
  String _resp4;
  String _resp5;

  //Getter
  String get status => _status;
  String get isbn => _isbn;
  String get criador => _criador;
  String get capa => _capa;
  String get contracapa => _contracapa;
  String get lombada => _lombada;
  String get corteSuperior => _corteSuperior;
  String get corteDianteiro => _corteDianteiro;
  String get corteInferior => _corteInferior;
  String get resp1 => _resp1;
  String get resp2 => _resp2;
  String get resp3 => _resp3;
  String get resp4 => _resp4;
  String get resp5 => _resp5;

  //Setter
  changeStatus(String value) {
    _status = value;
    notifyListeners();
  }

  changeIsbn(String value) {
    _isbn = value;
    notifyListeners();
  }

  changeCriador(String value) {
    _criador = value;
    notifyListeners();
  }

  changeCapa(String value) {
    _capa = value;
    notifyListeners();
  }

  changeContracapa(String value) {
    _contracapa = value;
    notifyListeners();
  }

  changeLombada(String value) {
    _lombada = value;
    notifyListeners();
  }

  changeCorteSuperior(String value) {
    _corteSuperior = value;
    notifyListeners();
  }

  changeCorteDianteiro(String value) {
    _corteDianteiro = value;
    notifyListeners();
  }

  changeCorteInferior(String value) {
    _corteInferior = value;
    notifyListeners();
  }

  changeResp1(String value) {
    _resp1 = value;
    notifyListeners();
  }

  changeResp2(String value) {
    _resp2 = value;
    notifyListeners();
  }

  changeResp3(String value) {
    _resp3 = value;
    notifyListeners();
  }

  changeResp4(String value) {
    _resp4 = value;
    notifyListeners();
  }

  changeResp5(String value) {
    _resp5 = value;
    notifyListeners();
  }

  saveExemplar() {
    var newExemplar = Exemplar(
      status: status,
      isbn: isbn,
      criador: criador,
      capa: capa,
      contracapa: contracapa,
      lombada: lombada,
      corteSuperior: corteSuperior,
      corteDianteiro: corteDianteiro,
      corteInferior: corteInferior,
      resp1: resp1,
      resp2: resp2,
      resp3: resp3,
      resp4: resp4,
      resp5: resp5,
    );
    firestoreService.saveExemplar(newExemplar);
  }
}
