import 'package:dook/models/book_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/provider/exemplar_provider.dart';
import 'package:dook/provider/obra_provider.dart';
import 'package:dook/screens/anuncio/criar_anuncio_1.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_3.dart';

class CriarAnuncio2Screen extends StatefulWidget {
  @override
  Book book;
  String isbn;
  CriarAnuncio2Screen({this.book, this.isbn});
  CriarAnuncio2 createState() => CriarAnuncio2(book: book, isbn: isbn);
}

class CriarAnuncio2 extends State {
  Book book;
  String isbn;
  CriarAnuncio2({this.book, this.isbn});
  String aviso = '';

  void telaCriarAnuncio3() {
    Navigator.push(
        //Mudar para a tela do formulário de condição do livro
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CriarAnuncio3Screen()));
  }

  @override
  Widget build(BuildContext context) {
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
              height: 20.h,
            ),
            FormLivro(book: book, isbn: isbn),
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
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        Text(
          'Confirme os Dados',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 33.sp,
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

class FormLivro extends StatelessWidget {
  Book book;
  String isbn;
  FormLivro({this.book, this.isbn});

  final TextEditingController controladorISBN = TextEditingController();
  final TextEditingController controladorTitulo = TextEditingController();
  final TextEditingController controladorAutor = TextEditingController();
  final TextEditingController controladorEditora = TextEditingController();
  final TextEditingController controladorEdicao = TextEditingController();
  final TextEditingController controladorDtPub = TextEditingController();
  final TextEditingController controladorCategoria = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isbn != null) {
      controladorISBN.text = isbn;
    } else {
      controladorISBN.text = '';
    }
    if (book.titulo != null) {
      controladorTitulo.text = book.titulo;
    } else {
      controladorTitulo.text = '';
    }
    if (book.autor != null) {
      controladorAutor.text = book.autor;
    } else {
      controladorAutor.text = '';
    }
    if (book.editora != null) {
      controladorEditora.text = book.editora;
    } else {
      controladorEditora.text = '';
    }
    if (book.edicao != null) {
      controladorEdicao.text = book.edicao;
    } else {
      controladorEdicao.text = '';
    }
    if (book.dataPubli != null) {
      controladorDtPub.text = book.dataPubli;
    } else {
      controladorDtPub.text = '';
    }
    if (book.categoria != null) {
      controladorCategoria.text = book.categoria;
    } else {
      controladorCategoria.text = '';
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: controladorISBN,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "ISBN",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorTitulo,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Título",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorAutor,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Autor",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorEditora,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Editora",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorEdicao,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Edição",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorDtPub,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Data de Publicação",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controladorCategoria,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Categoria",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Text(
          'Separe as categorias por vírgula',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 48.h,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple[600],
            minimumSize: Size(382.h, 55.h),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          onPressed: () {
            final firestoreService = FirestoreService();
            if (controladorISBN.text != '' &&
                controladorTitulo.text != '' &&
                controladorEditora.text != '' &&
                controladorEdicao.text != '' &&
                controladorDtPub.text != '' &&
                controladorCategoria.text != '' &&
                controladorAutor.text != '') {
              ObraProvider obra = new ObraProvider();
              obra.changeIsbn(controladorISBN.text);
              obra.changeTitulo(controladorTitulo.text);
              obra.changeEditora(controladorEditora.text);
              obra.changeEdicao(controladorEdicao.text);
              obra.changeDataPubli(controladorDtPub.text);
              obra.changeAutor(controladorAutor.text);

              List<String> categoria = controladorCategoria.text.split(',');
              obra.changeCategoria(categoria);

              obra.saveObra();

              ExemplarProvider exemplar = new ExemplarProvider();
              exemplar.changeIsbn(controladorISBN.text);
              exemplar.changeStatus("aberto");
              exemplar.changeCriador(firestoreService.getEmail());

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CriarAnuncio3Screen(exemplar: exemplar)));
            }
          },
          child: Text(
            'Próximo',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ],
    );
  }
}
