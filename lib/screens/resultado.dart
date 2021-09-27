import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ResultadoScreen extends StatefulWidget {
  String isbn;
  ResultadoScreen({this.isbn});
  @override
  Resultado createState() => Resultado(isbn: isbn);
}

class Resultado extends State {
  String isbn;
  Resultado({this.isbn});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 35.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            ResultadoCabecalho(),
            ResultadoCorpo(isbn: isbn),
          ],
        ),
      ),
    );
  }
}

class ResultadoCabecalho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                  alignment: Alignment.centerLeft,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                width: 90.w,
              ),
              Container(
                child: Text('Resultado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 38.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                width: 220.w,
              ),
              Container(
                width: 70.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultadoCorpo extends StatelessWidget {
  String isbn;
  ResultadoCorpo({this.isbn});
  Widget build(BuildContext context) {
    FirestoreService firestore = new FirestoreService();
    return Container(
      child: StreamBuilder(
        stream: firestore.pesquisaExemplar(isbn),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  double media = (int.parse(
                              snapshot.data.docs[index]['respostas']['resp1']) +
                          int.parse(
                              snapshot.data.docs[index]['respostas']['resp2']) +
                          int.parse(
                              snapshot.data.docs[index]['respostas']['resp3']) +
                          int.parse(
                              snapshot.data.docs[index]['respostas']['resp4']) +
                          int.parse(snapshot.data.docs[index]['respostas']
                              ['resp5'])) /
                      5;

                  int mediaRound = media.round();
                  return ListTile(
                    onTap: () {
                      //mudar para tela de anuncio
                      print('foi');
                    },
                    title: Text('media - $mediaRound',
                        style: TextStyle(
                          fontSize: 20.sp,
                        )),
                    subtitle: Text('oi',
                        style: TextStyle(
                          fontSize: 15.sp,
                        )),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('vazio'),
            );
          }
        },
      ),
    );
  }
}
