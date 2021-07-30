import 'package:dook/screens/login.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  @override
  Cadastro createState() => Cadastro();
}

class Cadastro extends State {
  void telaLogin() {
    Navigator.push(
        //Mudar para Tela de Cadastro
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40,
          left: 40,
          right: 40,
        ),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(children: <Widget>[
              Expanded(child: Text('')),
              Expanded(
                  child: Text('Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ))),
              Expanded(
                //Botao Cadastrar
                child: TextButton(
                  child: Text(
                    'Entrar',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(47, 128, 237, 1.0),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.centerRight,
                  ),
                  onPressed: telaLogin,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
