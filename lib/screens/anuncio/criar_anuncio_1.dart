import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_2.dart';

class CriarAnuncio1Screen extends StatefulWidget {
  @override
  CriarAnuncio1 createState() => CriarAnuncio1();
}

class CriarAnuncio1 extends State {
  final TextEditingController _controladorISBN = TextEditingController();

  void telaCriarAnuncio2() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CriarAnuncio2Screen()));
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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Superior(),
              SizedBox(
                height: 270.h,
              ),
              TextField(
                controller: _controladorISBN,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 310.h,
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
                  debugPrint(_controladorISBN.text);
                  final isbn = _controladorISBN.text;
                  telaCriarAnuncio2();
                },
                child: Text(
                  'Próximo',
                  style: TextStyle(fontSize: 18.sp),
                ),
                //color: Colors.deepPurple[600],
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
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
          ),
        ),
        Text(
          'ISBN do Livro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 35.sp,
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
