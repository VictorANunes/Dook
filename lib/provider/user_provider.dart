import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _nome;
  int _idade;

  //Get
  String get nome => _nome;
  int get idade => _idade;

  //Set
  changeNome(String value) {
    _nome = value;
    notifyListeners();
  }

  changeIdade(String value) {
    _idade = int.parse(value);
    notifyListeners();
  }

  saveUser() {
    var newUser = Users(nome: nome, idade: idade);
    print("$nome, $idade");
    firestoreService.saveUser(newUser);
  }

  removeUser(String id) {}
}
