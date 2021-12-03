import 'package:dook/models/book_models.dart';
import 'package:dook/screens/menu.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/services/get_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_2.dart';

class CriarAnuncio1Screen extends StatefulWidget {
  @override
  CriarAnuncio1 createState() => CriarAnuncio1();
}

class CriarAnuncio1 extends State {
  final TextEditingController _controladorISBN = TextEditingController();
  String aviso = '';

  void telaCriarAnuncio2(Book book, String isbn) {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                CriarAnuncio2Screen(book: book, isbn: isbn)));
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    GetBook getBook = new GetBook();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 35.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 270.h,
            ),
            TextField(
              controller: _controladorISBN,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.ssp),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple[600]),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              '$aviso',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.ssp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 270.h,
            ),
            Container(
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[600],
                  minimumSize: Size(382.h, 55.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: () async {
                  final isbn = _controladorISBN.text;
                  if (isbn != '' && isbn.length == 13) {
                    Book book;
                    book = await firestore.getBook(isbn);
                    if (book == null) {
                      book = await getBook.getData(isbn);
                    }
                    //Book book = await getBook.getData(isbn);
                    telaCriarAnuncio2(book, isbn);
                  } else {
                    setState(() {
                      aviso = 'Insira um ISBN válido!';
                    });
                  }
                },
                child: Text(
                  'Próximo',
                  style: TextStyle(fontSize: 18.ssp),
                ),
                //color: Colors.deepPurple[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Superior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/icons/voltar.png',
            height: 25.h,
            width: 25.w,
          ),
          alignment: Alignment.centerLeft,
        ),
        Text(
          'ISBN do Livro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 35.ssp,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 30.r,
          ),
        ),
      ],
    );
  }
}
