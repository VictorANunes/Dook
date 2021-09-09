import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/screens/cadastro/cadastro_1.dart';
import 'package:dook/screens/recsenha.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  Login createState() => Login();
}

class Login extends State {
  @override
  final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final senha = TextEditingController();
  var erro = '';
  bool mostrarsenha = false;

  void telaCadastro() {
    Navigator.push(
        //Mudar para Tela de Cadastro
        context,
        MaterialPageRoute(builder: (BuildContext context) => CadastroScreen()));
  }

  void telaRecSenha() {
    Navigator.push(
        //Mudar para Tela de Cadastro
        context,
        MaterialPageRoute(builder: (BuildContext context) => RecSenhaScreen()));
  }

  void _loginAuth() async {
    _auth
        .signInWithEmailAndPassword(email: email.text, password: senha.text)
        .then((user) {
      FirestoreService firestore = new FirestoreService();
      firestore.pegarDados(email.text);
    }).catchError((e) {
      setState(() {
        erro = 'Email ou Senha estão incorretos!';
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 45.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '',
                    ),
                  ),
                  Expanded(
                    //Texto Entrar
                    child: Text(
                      'Entrar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    //Botao Cadastrar
                    child: TextButton(
                      child: Text(
                        'Cadastrar',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color.fromRGBO(47, 128, 237, 1.0),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: ButtonStyle(
                        alignment: Alignment.centerRight,
                      ),
                      onPressed: telaCadastro,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            TextFormField(
              //Input Email
              controller: email,
              keyboardType: TextInputType.emailAddress,
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
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              //Input Senha
              controller: senha,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 5.r,
                  bottom: 5.r,
                  left: 15.r,
                  right: 15.r,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
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
                        fontSize: 18.sp,
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
              height: 10.h,
            ),
            Text('$erro',
                style: TextStyle(
                  //fontFamily: 'Inter',
                  fontSize: 17.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 40.h,
            ),
            ElevatedButton(
              //Botão Entrar
              onPressed: () async {
                _loginAuth();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[600],
                minimumSize: Size(88.h, 55.h),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              //Botao pra recuperar senha
              child: Text(
                'Esqueceu sua Senha?',
                style: TextStyle(
                  color: Color.fromRGBO(47, 128, 237, 1.0),
                  fontSize: 16.sp,
                ),
              ),
              onPressed: telaRecSenha,
            ),
          ],
        ),
      ),
    );
  }
}
