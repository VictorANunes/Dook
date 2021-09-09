import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/provider/user_provider.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class InteresseScreen extends StatefulWidget {
  @override
  Interesse createState() => Interesse();
}

class Interesse extends State {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = new FirestoreService();
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            //MenuPerfil(),
            //MenuLista(),
            SizedBox(
              height: 200.h,
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: firestore.pegarDados(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Center(child: new CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return Text(snapshot.data['nome']);
                  } else {
                    return Text('vazio');
                  }
                }),
          ],
          //MenuSair(),
        ),
      ),
    );
  }
}
