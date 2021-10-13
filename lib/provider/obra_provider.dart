import 'package:dook/models/obra_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class ObraProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _isbn;
  String _titulo;
  String _editora;
  String _autor;
  String _edicao;
  String _dataPubli;
  List<String> _categoria;

  //Getter
  String get isbn => _isbn;
  String get titulo => _titulo;
  String get editora => _editora;
  String get autor => _autor;
  String get edicao => _edicao;
  String get dataPubli => _dataPubli;
  List<String> get categoria => _categoria;

  //Setter
  changeIsbn(String value) {
    _isbn = value;
    notifyListeners();
  }

  changeTitulo(String value) {
    _titulo = value;
    notifyListeners();
  }

  changeEditora(String value) {
    _editora = value;
    notifyListeners();
  }

  changeAutor(String value) {
    _autor = value;
    notifyListeners();
  }

  changeEdicao(String value) {
    _edicao = value;
    notifyListeners();
  }

  changeDataPubli(String value) {
    _dataPubli = value;
    notifyListeners();
  }

  changeCategoria(List<String> value) {
    _categoria = value;
    notifyListeners();
  }

  saveObra() {
    var newObra = Obra(
        isbn: isbn,
        titulo: titulo,
        editora: editora,
        autor: autor,
        edicao: edicao,
        dataPubli: dataPubli,
        categoria: categoria);
    firestoreService.saveObra(newObra);
  }
}
