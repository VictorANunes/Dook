import 'dart:io';

import 'package:dook/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CadastroScreen5 extends StatefulWidget {
  UserProvider user;
  CadastroScreen5({this.user});
  @override
  Cadastro5 createState() => Cadastro5(user: user);
}

class Cadastro5 extends State {
  UserProvider user;
  Cadastro5({this.user});
  File _image;
  String _url =
      'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';
  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    Future getImage() async {
      var image = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
      });
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40,
          left: 25,
          right: 25,
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
                    width: 90,
                  ),
                  Container(
                    child: Text(
                      'Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 38,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    width: 200,
                  ),
                  Container(
                    width: 90,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
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
              height: 10,
            ),
            TextButton(
              child: Text(
                'Adicionar Foto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(47, 128, 237, 1.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                getImage();
              },
            ),
            SizedBox(
              height: 185,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  String fileName = basename(_image.path); //arrumar
                  await FirebaseStorage.instance
                      .ref()
                      .child(fileName)
                      .putFile(_image);
                  String url = await FirebaseStorage.instance
                      .ref()
                      .child(fileName)
                      .getDownloadURL();
                  setState(() {
                    _url = url;
                    print(_url);
                  });
                  user.changeUrl(_url);
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
                minimumSize: Size(88, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Próximo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Adicionar Depois',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
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
