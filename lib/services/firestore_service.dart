import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
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
        print("oi");
        //deslogado
        return false;
      } else if (user != null) {
        print("tchau");
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.senha);
    try {
      _db.collection('Usuario').doc(user.email).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Users>> getDataUser(String email) {
    //Pegar todos usuários
    return _db.collection('Usuario').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Users.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeUser(String id) {
    return _db.collection('userteste').doc(id).delete();
  }

  Stream<Users> getDadosUsuario() {
    //Pegar dados do prório usuário
    var email = getEmail();
    final result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data()));
    return result;
  }

  Stream<Users> getUsuario(email) {
    //Pegar dados de outro usuário
    var result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data()));
    return result;
  }

  //----------OBRA----------//
  Stream<QuerySnapshot<Map<String, dynamic>>> resultadoPesquisa(texto) {
    final result = _db
        .collection('Obra')
        .where('pesqList', arrayContains: texto)
        .limit(15)
        .snapshots();
    return result;
  }

  void pesquisaList(String titulo, String editora, String autor) {
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

    _db.collection('Obra').doc().set({
      'titulo': titulo,
      'editora': editora,
      'autor': autor,
      'pesqList': pesqList
    });
  }

  Stream<Obra> getObra(String isbn) {
    var result = _db
        .collection('Obra')
        .doc(isbn)
        .snapshots()
        .map((event) => Obra.fromFirestore(event.data()));
    return result;
  }

  //----------EXEMPLAR----------//
  Stream<QuerySnapshot<Map<String, dynamic>>> pesquisaExemplar(String isbn) {
    final result = _db
        .collection('Exemplar')
        .where('isbn', isEqualTo: isbn)
        .where('status', isEqualTo: 'aberto')
        .snapshots();
    return result;
  }

  Stream<List<Exemplar>> getMeusAnuncios() {
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
    //print(firestore['livrosDoados']);
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
