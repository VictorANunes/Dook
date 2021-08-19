import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:dook/screens/cadastro/cadastro_4.dart';

class CadastroScreen3 extends StatefulWidget {
  UserProvider user;
  CadastroScreen3({this.user});
  @override
  Cadastro3 createState() => Cadastro3(user: user);
}

class Cadastro3 extends State {
  UserProvider user;
  Cadastro3({this.user});
  @override
  String aviso = '';
  final cep = TextEditingController();
  final rua = TextEditingController();
  final bairro = TextEditingController();
  final numero = TextEditingController();
  final complemento = TextEditingController();
  final estado = TextEditingController();
  final uf = TextEditingController();
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
              child: Row(children: <Widget>[
                Container(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
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
                  width: 90,
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'CEP *',
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
              controller: cep,
              inputFormatters: [
                MaskedTextInputFormatterShifter(
                    maskONE: "XXXXX-XXX", maskTWO: "XXXXX-XXX"),
              ],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.yellow)),
                labelText: "XXXXX-XXX",
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
              'Rua *',
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
              controller: rua,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.yellow)),
                labelText: "Digite...",
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
              'Bairro *                                          Numero *',
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
            Row(
              children: <Widget>[
                Container(
                  width: 230,
                  child: TextFormField(
                    controller: bairro,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.yellow)),
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 135,
                  child: TextFormField(
                    controller: numero,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.yellow)),
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Complemento',
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
              controller: complemento,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.yellow)),
                labelText: "Digite...",
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
              'Estado *                                         UF *',
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
            Row(
              children: <Widget>[
                Container(
                  width: 230,
                  child: TextFormField(
                    controller: estado,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.yellow)),
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 135,
                  child: TextFormField(
                    inputFormatters: [
                      MaskedTextInputFormatterShifter(
                          maskONE: "XX", maskTWO: "XX"),
                    ],
                    controller: uf,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.yellow)),
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
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
              height: 70,
            ),
            ElevatedButton(
              onPressed: () {
                String mensagem = '';
                if (cep.text != '' &&
                    rua.text != '' &&
                    bairro.text != '' &&
                    numero.text != '' &&
                    estado.text != '' &&
                    uf.text != '') {
                  if (cep.text.length == 9) {
                    if (uf.text.length == 2) {
                      user.changeCep(cep.text);
                      user.changeRua(rua.text);
                      user.changeBairro(bairro.text);
                      user.changeNumero(numero.text);
                      user.changeComplemento(complemento.text);
                      user.changeEstado(estado.text);
                      user.changeUf(uf.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CadastroScreen4(user: user)));
                    } else {
                      mensagem = 'Insira um UF válido';
                    }
                  } else {
                    mensagem = 'Insira um Cep válido!';
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
          ],
        ),
      ),
    );
  }
}
