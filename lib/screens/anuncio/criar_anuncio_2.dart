import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_3.dart';

class CriarAnuncio2Screen extends StatefulWidget {
  @override
  CriarAnuncio2 createState() => CriarAnuncio2();
}

class CriarAnuncio2 extends State {

  void telaCriarAnuncio3() {
    Navigator.push(
        //Mudar para a tela do formulário de condição do livro
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CriarAnuncio3Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: 40.r,
            left: 25.r,
            right: 25.r,
          ),
          child: Column(
            children: <Widget>[
              Superior(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FormLivro(),
              ),
              SizedBox(
                height: 50.h,
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
                  telaCriarAnuncio3();
                },
                child: Text(
                  'Próximo',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ],
          ),
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
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
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
  final TextEditingController controladorISBN = TextEditingController();
  final TextEditingController controladorTitulo = TextEditingController();
  final TextEditingController controladorAutor = TextEditingController();
  final TextEditingController controladorEditora = TextEditingController();
  final TextEditingController controladorEdicao = TextEditingController();
  final TextEditingController controladorDtPub = TextEditingController();
  final TextEditingController controladorCategoria = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
      ],
    );
  }
}
