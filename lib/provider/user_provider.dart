import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _nome;
  int _idade;

  //Get
  String get nome => _nome;

  //Set
  changeNome(String value) {
    _nome = value;
    notifyListeners();
  }

  saveUser() {
    var newUser = Users(nome: nome);
    firestoreService.saveUser(newUser);
  }

  removeUser(String id) {}
}
