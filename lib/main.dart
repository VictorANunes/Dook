import 'package:dook/provider/user_provider.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:flutter/material.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAppCheck.instance
  //    .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  await OneSignal.shared.setAppId("58ff9b98-3a87-402f-a917-053baa5a8cc6");

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
    var currentUser = FirebaseAuth.instance.currentUser;
    var email;
    if (currentUser != null) {
      email = currentUser.email;
    }
    final firestoreService = FirestoreService();
    return ScreenUtilInit(
      designSize: Size(432, 816),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          StreamProvider(
            create: (context) => firestoreService.getDataUser(email),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.deepPurple[600],
          ),
          home: LoginScreen(),
        ),
      ),
    );
  }
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    var currentUser = FirebaseAuth.instance.currentUser;
    var email;
    if (currentUser != null) {
      email = currentUser.email;
    }
    return ScreenUtilInit(
      designSize: Size(432, 816),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          StreamProvider(
            create: (context) => firestoreService.getDataUser(email),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MenuInferiorScreen(),
        ),
      ),
    );
  }
}
