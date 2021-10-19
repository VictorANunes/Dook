import 'package:dook/models/chat_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  final firestore = FirestoreService();
  String _doador;
  String _receptor;
  String _exemplar;
  int _data;

  //Getter
  String get doador => _doador;
  String get receptor => _receptor;
  String get exemplar => _exemplar;
  int get data => _data;

  //Setter
  changeDoador(String value) {
    _doador = value;
    notifyListeners();
  }

  changeReceptor(String value) {
    _receptor = value;
    notifyListeners();
  }

  changeExemplar(String value) {
    _exemplar = value;
    notifyListeners();
  }

  changeData(int value) {
    _data = value;
    notifyListeners();
  }

  saveChat() {
    var newChat = Chat(
        doador: doador, receptor: receptor, exemplar: exemplar, data: data);
    firestore.saveChat(newChat);
  }
}
