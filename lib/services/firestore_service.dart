import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/provider/exemplar_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/models/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class FirestoreService extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
//FirebaseFirestore.instance.collection('collection_Name').doc('doc_Name').collection('collection_Name').doc(code.documentId).update({'redeem': true});

  String getEmail() {
    var currentUser = FirebaseAuth.instance.currentUser;
    var email;
    if (currentUser != null) {
      email = currentUser.email;
    } else {
      email = null;
    }
    return email;
  }

  //----------LOGIN----------//
  Future<bool> LoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        //deslogado
        return false;
      } else if (user != null) {
        //logado
        return true;
      }
    });
    notifyListeners();
  }

  Future<void> SignOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  //----------USUÁRIOS----------//
  Future<void> saveUser(Users user) async {
    //Salvar usuário no Firebase
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.senha);
    try {
      _db.collection('Usuario').doc(user.email).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Users>> getDataUser(String email) {
    //Pegar todos usuários cadastrados
    return _db.collection('Usuario').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Users.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeUser(String id) {
    return _db.collection('userteste').doc(id).delete();
  }

  Stream<Users> getDadosUsuario() {
    //Pegar dados do prório usuário pegando seu próprio e-mail
    var email = getEmail();
    final result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data()));
    return result;
  }

  Stream<Users> getUsuario(email) {
    //Pegar dados de outro usuário através de seu ID(Email)
    var result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data()));
    return result;
  }

  //----------OBRA----------//
  Future<void> saveObra(Obra obra) async {
    //Salvar Obra no Firebase
    try {
      await _db
          .collection('Obra')
          .doc(obra.isbn)
          .set(obra.toMap(pesqList(obra.titulo, obra.editora, obra.autor)));
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> resultadoPesquisa(texto) {
    //Mostrar o resultado da pesquisa
    final result = _db
        .collection('Obra')
        .where('pesqList', arrayContains: texto)
        .limit(15)
        .snapshots();
    return result;
  }

  List<String> pesqList(String titulo, String editora, String autor) {
    String s = "";
    String s2 = "";
    if (titulo != null) {
      s = s + titulo + ",";
      s2 = s2 + titulo + " ";
    }
    if (autor != null) {
      s = s + autor;
      s2 = s2 + autor;
    }

    List<String> splitList = s.split(",") + s2.split(" ");
    List<String> pesqList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + 1; j++) {
        pesqList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }

    return pesqList;
  }

  Stream<Obra> getObra(String isbn) {
    //Pegar uma Obra de acordo com seu ID (isbn)
    var result = _db
        .collection('Obra')
        .doc(isbn)
        .snapshots()
        .map((event) => Obra.fromFirestore(event.data()));
    return result;
  }

  //----------EXEMPLAR----------//
  Future<void> saveExemplar(Exemplar exemplar) async {
    //Salvar Exemplar no Firebase
    var lastId = await _db
        .collection('Exemplar')
        .get()
        .then((value) => value.docs.last.id);

    var id = int.parse(lastId) + 1;
    try {
      await _db.collection('Exemplar').doc(id.toString()).set(exemplar.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> pesquisaExemplar(String isbn) {
    //Mostrar o resultado da pesquisa de acordo com o isbn do livro e o status aberto do Exemplar
    final result = _db
        .collection('Exemplar')
        .where('isbn', isEqualTo: isbn)
        .where('status', isEqualTo: 'aberto')
        .snapshots();
    return result;
  }

  Stream<List<Exemplar>> getMeusAnuncios() {
    //Pegar os Exemplares com o criador igual ao seu e-mail
    String email = getEmail();
    var result = _db
        .collection('Exemplar')
        .where('criador', isEqualTo: email)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Exemplar.fromFirestore(e.data())).toList());
    return result;
  }

  Stream<Exemplar> getExemplar(String id) {
    //Pegar Exemplar através de seu ID
    var result = _db
        .collection('Exemplar')
        .doc(id)
        .snapshots()
        .map((event) => Exemplar.fromFirestore(event.data()));
    return result;
  }

//Recuperar dados e salvar em uma variável
  Future<String> testeUser() async {
    var result = await _db
        .collection('Usuario')
        .doc('luis@gmail.com')
        .snapshots()
        .map((snapshot) => testeUser2(snapshot.data()))
        .first;
  }

  void testeUser2(Map<String, dynamic> firestore) {
    List<String> livrosDoados = List.from(firestore['livrosDoados']);
    print(livrosDoados[0]);
    //String nome = firestore['nome'];
    //return nome;
  }

  //LOGIN GOOGLE
  /*Future<String> signInwithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }*/
}
