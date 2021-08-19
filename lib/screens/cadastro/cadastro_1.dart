import 'package:dook/provider/user_provider.dart';
import 'package:dook/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/cadastro/cadastro_2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class CadastroScreen extends StatefulWidget {
  @override
  Cadastro createState() => Cadastro();
}

class Cadastro extends State {
  var aviso = '';
  bool mostrarsenha = false;
  bool mostrarsenha2 = false;
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final rsenha = TextEditingController();

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
          left: 25,
          right: 25,
        ),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(children: <Widget>[
              Container(
                child: IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    size: 30,
                  ),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                width: 90,
              ),
              Container(
                child: Text('Cadastro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 38,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                width: 200,
              ),
              Container(
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
                width: 90,
              ),
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Nome *',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: nome,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Nome Completo",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Email *',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "exemplo@gmail.com",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Senha *',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: senha,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(7),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: "Senha",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              suffix: GestureDetector(
                onTap: () {
                  //Atualizar ao Clicar
                  setState(() {
                    mostrarsenha = !mostrarsenha;
                  });
                },
                child: TextButton(
                  //Botao Mostrar no Input de Senha
                  child: Text(
                    //false = Mostrar e true = Esconder
                    mostrarsenha == false ? 'Mostrar' : 'Esconder',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(47, 128, 237, 1.0),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            //determinar o obscure de acordo com a variavel mostrarsenha]
            //obscure true esonde a senha e false mostra
            obscureText: mostrarsenha == false ? true : false,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Repetir Senha *',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: rsenha,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(7),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: "Repetir Senha",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              suffix: GestureDetector(
                onTap: () {
                  //Atualizar ao Clicar
                  setState(() {
                    mostrarsenha2 = !mostrarsenha2;
                  });
                },
                child: TextButton(
                  //Botao Mostrar no Input de Senha
                  child: Text(
                    //false = Mostrar e true = Esconder
                    mostrarsenha2 == false ? 'Mostrar' : 'Esconder',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(47, 128, 237, 1.0),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            //determinar o obscure de acordo com a variavel mostrarsenha]
            //obscure true esonde a senha e false mostra
            obscureText: mostrarsenha2 == false ? true : false,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$aviso',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 165,
          ),
          ElevatedButton(
            onPressed: () async {
              final _auth = FirebaseAuth.instance;
              UserProvider user = new UserProvider();
              var mensagem = '';
              if (nome.text != '' && email.text != '' && senha.text != '') {
                final bool emailTest = EmailValidator.validate(email.text);
                if (GetUtils.isEmail(email.text) == false) {
                  mensagem = 'Insira um email válido!';
                } else {
                  if (senha.text.length >= 8) {
                    if (senha.text == rsenha.text) {
                      var em = email.text;
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: "$em", password: " ");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          //print(e.code);
                          user.changeNome(nome.text);
                          user.changeEmail(email.text);
                          user.changeSenha(senha.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CadastroScreen2(user: user)));
                        } else if (e.code == 'wrong-password') {
                          mensagem = "Este email já está cadastrado!";
                          //print(e.code);
                        }
                      }
                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                                email: email.text, password: ' ');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                        } else if (e.code == 'user-not-found') {}
                      }
                    } else {
                      mensagem = 'As senhas não conferem!';
                    }
                  } else {
                    mensagem = 'A senha deve possuir no minimo 8 caracteres!';
                  }
                }
              } else {
                mensagem = '* Preencha os campos obrigatórios!';
              }
              setState(() {
                aviso = mensagem;
              });
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
        ]),
      ),
    );
  }
}
