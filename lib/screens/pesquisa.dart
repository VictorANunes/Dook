import 'package:dook/models/book_models.dart';
import 'package:dook/services/get_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PesquisaScreen extends StatefulWidget {
  @override
  Pesquisa createState() => Pesquisa();
}

class Pesquisa extends State {
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
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            PesquisaCabecalho(),
          ],
        ),
      ),
    );
  }
}

class PesquisaCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
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
