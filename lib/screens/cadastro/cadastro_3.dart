import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:dook/screens/cadastro/cadastro_4.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final cidade = TextEditingController();
  //final uf = TextEditingController();

  String uf;
  List<String> ufs = [
    'AC',
    'AL',
    'AM',
    'AP',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  Widget build(BuildContext context) {
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
              child: Row(children: <Widget>[
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/icons/voltar.png',
                      height: 25.h,
                      width: 25.w,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  width: 90.w,
                ),
                Container(
                  child: Text('Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 38.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  width: 200.w,
                ),
                Container(
                  width: 90.w,
                ),
              ]),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'CEP *',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: cep,
              inputFormatters: [
                MaskedTextInputFormatterShifter(
                    maskONE: "XXXXX-XXX", maskTWO: "XXXXX-XXX"),
              ],
              keyboardType: TextInputType.text,
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
                labelText: "XXXXX-XXX",
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
            Text(
              'Rua *',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: rua,
              keyboardType: TextInputType.text,
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
                labelText: "Digite...",
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
            Text(
              'Bairro *                                          Numero *',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 230.w,
                  child: TextFormField(
                    controller: bairro,
                    keyboardType: TextInputType.text,
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
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  width: 135.w,
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
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Complemento',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: complemento,
              keyboardType: TextInputType.text,
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
                labelText: "Digite...",
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
            Text(
              'Cidade *                                         UF *',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 230.w,
                  child: TextFormField(
                    controller: cidade,
                    keyboardType: TextInputType.text,
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
                      labelText: "Digite...",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  width: 135.w,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: 20.r,
                        bottom: 20.r,
                        left: 15.r,
                        right: 15.r,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                      hintText: "UF",
                    ),
                    value: uf,
                    onChanged: (String Value) {
                      setState(() {
                        uf = Value;
                      });
                    },
                    items: ufs
                        .map(
                          (ufs) => DropdownMenuItem(
                            value: ufs,
                            child: Text("$ufs"),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '$aviso',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            ElevatedButton(
              onPressed: () {
                String mensagem = '';
                if (cep.text != '' &&
                    rua.text != '' &&
                    bairro.text != '' &&
                    numero.text != '' &&
                    cidade.text != '' &&
                    uf != null) {
                  if (cep.text.length == 9) {
                    user.changeCep(cep.text);
                    user.changeRua(rua.text);
                    user.changeBairro(bairro.text);
                    user.changeNumero(numero.text);
                    user.changeComplemento(complemento.text);
                    user.changeCidade(cidade.text);
                    user.changeUf(uf);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CadastroScreen4(user: user)));
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
          ],
        ),
      ),
    );
  }
}
