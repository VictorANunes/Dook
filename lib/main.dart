import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/screens/login.dart';
import 'package:dook/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //mostra se usuario ta logado
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      //deslogado
      runApp(LoginApp());
    } else {
      //logado
      runApp(MenuApp());
    }
  });
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          //StreamProvider(
          //  create: (context) => firestoreService.getUsers('userteste'),
          //),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
        ));
  }
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          //StreamProvider(
          //    create: (context) => firestoreService.getUsers('userteste')),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        ));
  }
}
