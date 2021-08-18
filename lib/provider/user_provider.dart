import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _nome;
  String _email;
  String _senha;

  //Get
  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;

  //Set
  changeNome(String value) {
    _nome = value;
    notifyListeners();
  }

  changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  changeSenha(String value) {
    _senha = value;
    notifyListeners();
  }

  saveUser() {
    var newUser = Users(nome: nome);
    firestoreService.saveUser(newUser);
  }

  removeUser(String id) {}
}
