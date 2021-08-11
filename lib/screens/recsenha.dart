import 'package:dook/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecSenhaScreen extends StatefulWidget {
  @override
  RecSenha createState() => RecSenha();
}

class RecSenha extends State {
  @override
  var erro = '';
  final email = TextEditingController();

  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Email de recuperação enviado!',
                  style: TextStyle(color: Colors.deepPurple[600])),
              content: Text(
                  'Verifique o email para acessar o link de recuperação da senha, caso não tenha recebido refaça este processo!'),
              actions: <Widget>[
                MaterialButton(
                    elevation: 3.0,
                    child: Text('OK',
                        style: TextStyle(color: Colors.deepPurple[600])),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginScreen()));
                    })
              ]);
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40,
          left: 20,
          right: 40,
        ),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                Container(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          size: 35, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    alignment: Alignment.centerLeft,
                    width: 60,
                    padding: EdgeInsets.only(
                      bottom: 3,
                    )),
                Container(
                  //Texto Entrar
                  child: Text(
                    'Recuperar Senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //fontFamily: 'Inter',
                      fontSize: 38,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  width: 310,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Email Cadastrado',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: TextFormField(
              //Input Email
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.yellow)),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              '$erro',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Será enviado um código de confirmação ao email inserido acima, como método de validação.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          ElevatedButton(
            //Botão Entrar
            onPressed: () async {
              final _auth = FirebaseAuth.instance;
              _auth
                  .sendPasswordResetEmail(email: email.text)
                  .then((value) => createAlert(context))
                  .catchError((e) {
                setState(() {
                  erro = 'Verifique se o e-mail está correto!';
                });
              });
              print(email.text);
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
              'Confirmar',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
