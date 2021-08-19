import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/login.dart';

class CadastroScreen5 extends StatefulWidget {
  UserProvider user;
  CadastroScreen5({this.user});
  @override
  Cadastro5 createState() => Cadastro5(user: user);
}

class Cadastro5 extends State {
  UserProvider user;
  Cadastro5({this.user});
  @override
  Widget build(BuildContext context) {
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
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_outlined,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      print("adicionar imagem");
                    },
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
                print("adicionar imagem");
              },
            ),
            SizedBox(
              height: 185,
            ),
            ElevatedButton(
              onPressed: () {
                user.saveUser();
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
