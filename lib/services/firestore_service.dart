import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/models/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class FirestoreService extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //USERS
  Future<void> saveUser(Users user) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.senha);
    try {
      _db.collection('Usuario').doc(user.email).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Users>> getDataUser(email) {
    return _db.collection('Usuario').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Users.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeUser(String id) {
    return _db.collection('userteste').doc(id).delete();
  }

  //LOGIN
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> pegarDados() {
    var currentUser = FirebaseAuth.instance.currentUser;
    var email;
    if (currentUser != null) {
      email = currentUser.email;
    }
    final result = _db.collection('Usuario').doc(email).snapshots();
    return result;
  }

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

  Stream<QuerySnapshot<Map<String, dynamic>>> pesquisaExemplar(isbn) {
    final result =
        _db.collection('Exemplar').where('isbn', isEqualTo: isbn).snapshots();
    return result;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUsuario(email) {
    var result = _db.collection('Usuario').doc(email).snapshots();
    return result;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getObra(isbn) {
    var result = _db.collection('Obra').doc(isbn).snapshots();
    return result;
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
