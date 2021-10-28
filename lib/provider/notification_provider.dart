import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:dook/models/notification_models.dart';

class NotificationProvider with ChangeNotifier {
  final firestore = FirestoreService();
  String _titulo;
  String _msg;
  String _tipoMensagem;
  String _email;
  int _data;

  //Getter
  String get titulo => _titulo;
  String get msg => _msg;
  String get tipoMensagem => _tipoMensagem;
  String get email => _email;
  int get data => _data;

  //Setter
  changeTitulo(String value) {
    _titulo = value;
    notifyListeners();
  }

  changeMsg(String value) {
    _msg = value;
    notifyListeners();
  }

  changeTipoMensagem(String value) {
    _tipoMensagem = value;
    notifyListeners();
  }

  changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  changeData(int value) {
    _data = value;
    notifyListeners();
  }

  saveNotification() {
    var newNot = Notification2(
        titulo: titulo,
        msg: msg,
        tipoMensagem: tipoMensagem,
        email: email,
        data: data);
    firestore.saveNotification(newNot);
  }
}
