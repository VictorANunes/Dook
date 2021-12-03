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
            FormLivroState(book: book, isbn: isbn),
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
          'Confirme os Dados',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 33.ssp,
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

class FormLivroState extends StatefulWidget {
  Book book;
  String isbn;
  FormLivroState({this.book, this.isbn});
  FormLivro createState() => FormLivro(book: book, isbn: isbn);
}

final TextEditingController controladorISBN = TextEditingController();
final TextEditingController controladorTitulo = TextEditingController();
final TextEditingController controladorAutor = TextEditingController();
final TextEditingController controladorEditora = TextEditingController();
final TextEditingController controladorEdicao = TextEditingController();
final TextEditingController controladorDtPub = TextEditingController();
final TextEditingController controladorCategoria = TextEditingController();

class FormLivro extends State {
  Book book;
  String isbn;
  void addGenero2(String cat) {
    setState(() {
      if (!generosLivro.contains(cat)) {
        generosLivro.add(cat);
      }
    });
  }

  List<String> generosLivro = [];

  FormLivro({this.book, this.isbn}) {
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
      for (var i in book.categoria) {
        if (!generosLivro.contains(i)) {
          generosLivro.add(i);
        }
      }
    }
  }

  List<String> generos = [
    'Ação',
    'Aventura',
    'Terror',
    'Infantil',
    'Educação',
    'Material Acadêmico',
    'Infanto-Juvenil',
    'Romance',
    'Romance Biográfico',
    'Romance Epistolar',
    'Romance Histórico',
    'Romance Psicólogo',
    'Novela',
    'Conto',
    'Crônica',
    'Ensaio',
    'Poesia',
    'Carta',
    'Biografia',
    'Memórias',
    'Drama',
    'Graphic Novel',
    'História em Quadrinhos (HQ)',
    'Lad-Lit',
    'Literatura fantástica',
    'Literatura Infantil',
    'Literatura Infanto-juvenil',
    'New Adult',
    'Realismo Mágico',
    'Thriller ou suspense',
    'Conspiração',
    'Época',
    'Jurídico',
    'Médico',
    'Policial',
    'Psicológico',
    'Romântico',
    'Suspense',
    'Ficção',
    'Juvenil'
  ];
  int qtdGen = 0;
  String valuee;
  String dropDownValue;
  @override
  Widget build(BuildContext context) {
    void addGenero() {
      setState(() {
        if (!generosLivro.contains(dropDownValue)) {
          generosLivro.add(dropDownValue);
        }
      });
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: controladorISBN,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "ISBN",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "Título",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "Autor",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "Editora",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "Edição",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.deepPurple[600]),
              ),
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              labelText: "Ano de Publicação",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Selecione os gêneros",
            ),
            value: dropDownValue,
            onChanged: (String Value) {
              setState(() {
                dropDownValue = Value;
                addGenero();
              });
            },
            items: generos
                .map((generos) =>
                    DropdownMenuItem(value: generos, child: Text("$generos")))
                .toList(),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          child: Column(children: [
            //Parte que percorre a lista e cria Widgets Dinamicamente
            (generosLivro != null)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: generosLivro.length,
                    itemBuilder: (context, index) {
                      final item = generosLivro[index];
                      return Container(
                        child: Row(children: <Widget>[
                          Container(
                            width: 310.w,
                            child: Text(
                              '${item}',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 19.ssp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2.r),
                            child: IconButton(
                                alignment: Alignment.centerRight,
                                icon: Image.asset(
                                  'assets/images/icons/lixeira verm.png',
                                  height: 23.h,
                                  width: 23.w,
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    generosLivro.removeAt(index);
                                  });
                                }),
                          ),
                        ]),
                      );
                    },
                  )
                : Text(""),
          ]),
        ),
        SizedBox(
          height: 30.h,
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
                controladorAutor.text != '' &&
                !generosLivro.isEmpty) {
              ObraProvider obra = new ObraProvider();
              obra.changeIsbn(controladorISBN.text);
              obra.changeTitulo(controladorTitulo.text);
              obra.changeEditora(controladorEditora.text);
              obra.changeEdicao(controladorEdicao.text);
              obra.changeDataPubli(controladorDtPub.text);
              obra.changeAutor(controladorAutor.text);
              obra.changeCategoria(generosLivro);

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
            style: TextStyle(fontSize: 18.ssp),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
