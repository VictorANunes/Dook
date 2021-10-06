import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
          right: 15.r,
        ),
        child: ListView(
          children: <Widget>[
            ResultadoCabecalho(),
            SizedBox(
              height: 30.h,
            ),
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
                  var obra = firestore.getObra(isbn);
                  return ListTile(
                    onTap: () async {
                      //mudar para tela de anuncio
                      print(snapshot.data.docs[index].id);
                    },
                    title: StreamBuilder(
                      stream: obra,
                      builder:
                          (BuildContext context, AsyncSnapshot<Obra> obra) {
                        if (obra.hasData) {
                          return Text(obra.data.titulo,
                              style: TextStyle(
                                fontSize: 20.sp,
                              ));
                        } else {
                          return Text('');
                        }
                      },
                    ),
                    subtitle: StreamBuilder(
                      stream: firestore
                          .getUsuario(snapshot.data.docs[index]['criador']),
                      builder:
                          (BuildContext context, AsyncSnapshot<Users> usuario) {
                        if (usuario.hasData) {
                          return Text(
                              usuario.data.cidade + " - " + usuario.data.uf,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ));
                        } else {
                          return Text('');
                        }
                      },
                    ),
                    leading: Container(
                      width: 50.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              snapshot.data.docs[index]['fotos']['capa']),
                        ),
                      ),
                    ),
                    trailing: Container(
                      child: RatingBarIndicator(
                        rating: media,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.deepPurple[600],
                        ),
                        itemCount: 5,
                        itemSize: 19.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
