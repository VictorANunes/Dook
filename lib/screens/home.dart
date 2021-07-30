import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:dook/models/user_models.dart';

class HomeScreen extends StatefulWidget {
  @override
  Home createState() => Home();
}

class Home extends State {
  Widget build(BuildContext context) {
    final users = Provider.of<List<Users>>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              //Botão Sair
              onPressed: () async {
                final service = FirestoreService();
                await service.SignOut();
                Navigator.push(
                    //Mudar para Tela de Login
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(242, 201, 76, 1.0),
                minimumSize: Size(88, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Sair',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(242, 201, 76, 1.0),
                minimumSize: Size(88, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Mudar Tela',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
