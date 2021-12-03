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
  String _cidade;
  String _uf;
  String _url;
  List<String> _generos;
  List<String> _livros;
  String _id;

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
  String get cidade => _cidade;
  String get uf => _uf;
  String get url => _url;
  List<String> get generos => _generos;
  List<String> get livros => _livros;
  String get id => _id;

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

  changeCidade(String value) {
    _cidade = value;
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
    _generos = value;
    notifyListeners();
  }

  changeLivrosInt(List<String> value) {
    _livros = [];
    for (var i in value) {
      _livros.add(i.toLowerCase());
    }
    print(_livros);
    notifyListeners();
  }

  changeId(value) {
    _id = value;
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
        cidade: cidade,
        uf: uf,
        url: url,
        generos: generos,
        livros: livros,
        id: id);
    firestoreService.saveUser(newUser);
  }

  removeUser(String id) {}
}
