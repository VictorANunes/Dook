import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class CriarAnuncio4Screen extends StatefulWidget {
  @override
  CriarAnuncio4 createState() => CriarAnuncio4();
}

class CriarAnuncio4 extends State {
  /*void telaCriarAnuncio5() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CriarAnuncio5Screen()));
  }*/

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
          child: ListView(
            children: <Widget>[
              Superior(),
              SizedBox(
                height: 35.h,
              ),
              Text(
                '* Corte: parte visível das páginas quando o livro está fechado.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Fotos(),
              SizedBox(
                height: 150.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[600],
                  minimumSize: Size(382.h, 55.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: () {},
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
            Navigator.pop(context);
            //telaCriarAnuncio2();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
          ),
        ),
        Text(
          'Fotos',
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

class Fotos extends StatefulWidget {
  @override
  FotosState createState() => FotosState();
}

class FotosState extends State<Fotos> {
  File _image;
  String _url = '';
  //'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Capa',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Contracapa',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Lombada',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Corte Superior',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Corte Dianteiro',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Corte Inferior',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 220.w,
              height: 220.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0)
                    ),
                color: Colors.grey[600],
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: (_image != null)
                          ? FileImage(_image)
                          : NetworkImage(_url),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.deepPurple[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                //getImage();
              },
            ),
          ],
        ),
      ],
    );
  }
}
