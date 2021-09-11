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
        padding: EdgeInsets.only(
          top: 17.r,
          left: 19.r,
          right: 20.r,
        ),
        child: ListView(
          children: <Widget>[
            IntCabecalho(),
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

class IntCabecalho extends StatelessWidget {
  @override
  final pesquisa = TextEditingController();
  FocusNode fieldNode = FocusNode();
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 340.w,
            child: TextFormField(
              focusNode: fieldNode,
              cursorColor: Colors.deepPurple[600],
              controller: pesquisa,
              decoration: InputDecoration(
                hasFloatingPlaceholder: false,
                contentPadding: EdgeInsets.only(
                  top: 15.r,
                  bottom: 15.r,
                  left: 15.r,
                  right: 15.r,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.deepPurple[600])),
                labelText: "Pesquisar",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.deepPurple[600],
                    ),
                    onPressed: () {
                      print(pesquisa.text);
                    }),
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: 40.w,
            padding: EdgeInsets.only(bottom: 13.r),
            child: IconButton(
              icon: Icon(
                //Icons.notifications_none,
                //color: Colors.black45,
                Icons.notifications,
                color: Colors.deepPurple[600],
                size: 42,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
