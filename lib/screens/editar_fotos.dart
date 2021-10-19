import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class EditarFotosScreen extends StatefulWidget {
  @override
  EditarFotos createState() => EditarFotos();
}

class EditarFotos extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
              child: Text(
                'Salvar',
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
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
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
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
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
