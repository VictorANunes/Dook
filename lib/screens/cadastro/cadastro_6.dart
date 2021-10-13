import 'package:dook/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CadastroScreen6 extends StatefulWidget {
  UserProvider user;
  CadastroScreen6({this.user});
  @override
  Cadastro6 createState() => Cadastro6(user: user);
}

class Cadastro6 extends State {
  UserProvider user;
  Cadastro6({this.user});
  File _image;
  String _url =
      'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    Future getImageGallery() async {
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
      });
    }

    Future getImageCamera() async {
      var image = await imagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = File(image.path);
      });
    }

    void mostrarOpcaoFoto(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Galeria'),
                        onTap: () {
                          getImageGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImageCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    width: 90.w,
                  ),
                  Container(
                    child: Text(
                      'Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 38.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: 200.w,
                  ),
                  Container(
                    width: 90.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Container(
              width: 250.w,
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
                  color: Color.fromRGBO(47, 128, 237, 1.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                mostrarOpcaoFoto(context);
              },
            ),
            SizedBox(
              height: 185.h,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  String fileName = basename(_image.path);
                  UploadTask uploadTask = FirebaseStorage.instance
                      .ref()
                      .child(fileName)
                      .putFile(_image);

                  var imageUrl = await (await uploadTask).ref.getDownloadURL();
                  user.changeUrl(imageUrl);

                  user.saveUser();
                } else {
                  String url =
                      'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';
                  user.changeUrl(url);
                  user.saveUser();
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[600],
                minimumSize: Size(88.h, 50.h),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Próximo',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Adicionar Depois',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Color.fromRGBO(47, 128, 237, 1.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                String url =
                    'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';
                user.changeUrl(url);
                user.saveUser();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
