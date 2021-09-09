import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/models/user_models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

/*  Stream<List<Users>> getUsers(String tabela) {
    return _db.collection(tabela).snapshots().map((snapshot) => snapshot.docs
        .map((document) => Users.fromFirestore(document.data()))
        .toList());
  }*/

  Future<void> removeUser(String id) {
    return _db.collection('userteste').doc(id).delete();
  }

  //LOGIN
  Future<bool> LoginStatus() {
    //await Firebase.initializeApp();
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

  void pegarDados(email) {
    UserProvider usuario = UserProvider();
    List<String> generos = [];
    List<String> livros = [];
    final result =
        _db.collection('Usuario').doc(email).snapshots(); //no doc colocar email
    result.forEach((element) {
      usuario.changeNome(element['nome']);
      usuario.changeCpf(element['cpf']);
      usuario.changeEmail(email);
      usuario.changeDataNasc(element['datanasc']);
      usuario.changeSexo(element['sexo']);
      usuario.changeTelefone(element['telefone']);
      usuario.changeCep(element['endereco']['cep']);
      usuario.changeRua(element['endereco']['rua']);
      usuario.changeBairro(element['endereco']['bairro']);
      usuario.changeNumero(element['endereco']['numero']);
      usuario.changeComplemento(element['endereco']['complemento']);
      usuario.changeEstado(element['endereco']['estado']);
      usuario.changeUf(element['endereco']['uf']);
      usuario.changeUrl(element['foto']);

      for (int i = 1; i <= 5; i++) {
        generos.add(element['generosInteresse']['generos$i']);
        livros.add(element['livrosInteresse']['livros$i']);
      }

      usuario.changeGenerosInt(generos);
      usuario.changeLivrosInt(livros);

      print(usuario.nome);
    });
  }

  //LOGIN GOOGLE
  Future<String> signInwithGoogle() async {
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
  }
}
