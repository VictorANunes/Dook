import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/book_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/services/get_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PesquisaScreen extends StatefulWidget {
  @override
  Pesquisa createState() => Pesquisa();
}

class Pesquisa extends State {
  final pesquisa = TextEditingController();
  String textoo;
  FirestoreService firebase = new FirestoreService();
  Widget query = new Text('vazio');
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        height: 300,
        padding: EdgeInsets.only(
          top: 35.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            PesquisaCabecalho(),
            SizedBox(
              height: 30.h,
            ),
            Container(
                child: Column(
              children: <Widget>[
                TextFormField(
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
                  ),
                  onChanged: (texto) {
                    setState(() {
                      textoo = texto;
                    });
                  },
                ),
                StreamBuilder(
                    stream: firebase.resultadoPesquisa(textoo),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return new Center();
                      }
                      if (snapshot.hasData) {
                        return Center(
                            child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(snapshot.data.docs[index]['titulo']);
                          },
                        ));
                      } else {
                        return Text('vazio');
                      }
                    })
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class PesquisaCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                alignment: Alignment.centerLeft,
                onPressed: () async {
                  Navigator.of(context).pop();
                  /*GetBook getBook = new GetBook();
                  Book book =
                      await getBook.getData('9788501044457'); //colocar ISBN
                  print(book.titulo);
                  print(book.isbn);
                  print(book.editora);
                  print(book.autor);
                  print(book.edicao);
                  print(book.dataPubli);
                  print(book.categoria);*/
                },
              ),
              width: 90.w,
            ),
            Container(
              child: Text('Pesquisa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 38.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              width: 200.w,
            ),
            Container(
              width: 90.w,
            ),
          ]),
        ],
      ),
    );
  }
}

/*class PesquisaCorpo extends StatelessWidget {
  @override
  final pesquisa = TextEditingController();
  String textoo;
  FirestoreService firebase = new FirestoreService();
  Widget query = new Text('vazio');
  Widget build(BuildContext context) {
    return ;
  }
}*/
