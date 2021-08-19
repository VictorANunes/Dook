import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/models/user_models.dart';
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
    return _db.collection('Usuario').doc(user.email).set(user.toMap());
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
