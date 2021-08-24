import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _nome;
  String _email;
  String _senha;
  String _cpf;
  String _datanasc;
  String _sexo;
  String _telefone;
  String _cep;
  String _rua;
  String _bairro;
  String _numero;
  String _complemento;
  String _estado;
  String _uf;
  String _url;
  String _generos1 = '';
  String _generos2 = '';
  String _generos3 = '';
  String _generos4 = '';
  String _generos5 = '';
  String _livros1 = '';
  String _livros2 = '';
  String _livros3 = '';
  String _livros4 = '';
  String _livros5 = '';

  //Get
  String get nome => _nome;
  String get email => _email;
  String get senha => _senha;
  String get cpf => _cpf;
  String get datanasc => _datanasc;
  String get sexo => _sexo;
  String get telefone => _telefone;
  String get cep => _cep;
  String get rua => _rua;
  String get bairro => _bairro;
  String get numero => _numero;
  String get complemento => _complemento;
  String get estado => _estado;
  String get uf => _uf;
  String get url => _url;
  String get generos1 => _generos1;
  String get generos2 => _generos2;
  String get generos3 => _generos3;
  String get generos4 => _generos4;
  String get generos5 => _generos5;
  String get livros1 => _livros1;
  String get livros2 => _livros2;
  String get livros3 => _livros3;
  String get livros4 => _livros4;
  String get livros5 => _livros5;

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

  changeCpf(String value) {
    _cpf = value;
    notifyListeners();
  }

  changeDataNasc(String value) {
    _datanasc = value;
    notifyListeners();
  }

  changeSexo(String value) {
    _sexo = value;
    notifyListeners();
  }

  changeTelefone(String value) {
    _telefone = value;
    notifyListeners();
  }

  changeCep(String value) {
    _cep = value;
    notifyListeners();
  }

  changeRua(String value) {
    _rua = value;
    notifyListeners();
  }

  changeBairro(String value) {
    _bairro = value;
    notifyListeners();
  }

  changeNumero(String value) {
    _numero = value;
    notifyListeners();
  }

  changeComplemento(String value) {
    _complemento = value;
    notifyListeners();
  }

  changeEstado(String value) {
    _estado = value;
    notifyListeners();
  }

  changeUf(String value) {
    _uf = value;
    notifyListeners();
  }

  changeUrl(String value) {
    _url = value;
    notifyListeners();
  }

  changeGenerosInt(List<String> value) {
    for (var i = 0; i < value.length; i++) {
      switch (i) {
        case 0:
          _generos1 = value[0];
          break;
        case 1:
          _generos2 = value[1];
          break;
        case 2:
          _generos3 = value[2];
          break;
        case 3:
          _generos4 = value[3];
          break;
        case 4:
          _generos5 = value[4];
          break;
      }
    }
    notifyListeners();
  }

  changeLivrosInt(List<String> value) {
    for (var i = 0; i < value.length; i++) {
      switch (i) {
        case 0:
          _livros1 = value[0];
          break;
        case 1:
          _livros2 = value[1];
          break;
        case 2:
          _livros3 = value[2];
          break;
        case 3:
          _livros4 = value[3];
          break;
        case 4:
          _livros5 = value[4];
          break;
      }
    }
    notifyListeners();
  }

  saveUser() {
    var newUser = Users(
      nome: nome,
      email: email,
      senha: senha,
      cpf: cpf,
      datanasc: datanasc,
      sexo: sexo,
      telefone: telefone,
      cep: cep,
      rua: rua,
      bairro: bairro,
      numero: numero,
      complemento: complemento,
      estado: estado,
      uf: uf,
      url: url,
      generos1: generos1,
      generos2: generos2,
      generos3: generos3,
      generos4: generos4,
      generos5: generos5,
      livros1: livros1,
      livros2: livros2,
      livros3: livros3,
      livros4: livros4,
      livros5: livros5,
    );
    firestoreService.saveUser(newUser);
  }

  removeUser(String id) {}
}
