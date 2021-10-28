import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:dook/screens/cadastro/cadastro_3.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CadastroScreen2 extends StatefulWidget {
  UserProvider user;
  CadastroScreen2({this.user});
  @override
  Cadastro2 createState() => Cadastro2(user: user);
}

class Cadastro2 extends State {
  UserProvider user;
  Cadastro2({this.user});
  @override
  bool value = false;
  var aviso = '';
  final cpf = TextEditingController();
  final data_nasc = TextEditingController();
  final telefone = TextEditingController();
  final sexoText = TextEditingController();
  var sexoSwitch = 'Masculino';
  bool sexoCheck = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(children: <Widget>[
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
            'CPF *',
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
            controller: cpf,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
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
              labelText: "XXX.XXX.XXX-XX",
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
            'Data de Nascimento *',
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
            controller: data_nasc,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter(),
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
              ),
              labelText: "dd/mm/aaaa",
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
            'Sexo',
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
          ToggleSwitch(
            minWidth: 189.w,
            minHeight: 55.h,
            initialLabelIndex: 0,
            cornerRadius: 20.0,
            activeFgColor: Colors.grey[300],
            inactiveBgColor: Colors.grey[300],
            inactiveFgColor: Colors.grey[300],
            totalSwitches: 2,
            labels: ['Masculino', 'Feminino'],
            customTextStyles: [
              TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              )
            ],
            activeBgColors: [
              [Colors.white],
              [Colors.white]
            ],
            borderWidth: 1,
            borderColor: [Colors.grey[400]],
            onToggle: (index) {
              if (index == 0) {
                sexoSwitch = 'Masculino';
              } else {
                sexoSwitch = 'Feminino';
              }
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'Outro:',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            controller: sexoText,
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
              ),
              labelText: "Digite...",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                activeColor: Colors.deepPurple[600],
                value: this.value,
                onChanged: (bool value) {
                  setState(() {
                    this.value = value;
                    sexoCheck = value;
                  });
                },
              ),
              Text(
                'Prefiro não informar.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Telefone *',
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
            controller: telefone,
            inputFormatters: [
              MaskedTextInputFormatterShifter(
                  maskONE: "(XX)XXXXX-XXXX", maskTWO: "(XX)XXXXX-XXXX"),
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
              ),
              labelText: "(DDD)1234-1234",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
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
            height: 33.h,
          ),
          ElevatedButton(
            onPressed: () {
              //UserProvider user = new UserProvider();
              var _sexo = '';
              var mensagem = '';
              if (data_nasc.text != '' &&
                  telefone.text != '' &&
                  cpf.text != '') {
                if (GetUtils.isCpf(cpf.text)) {
                  if (sexoCheck == false) {
                    if (sexoText.text == '') {
                      _sexo = sexoSwitch;
                    } else {
                      _sexo = sexoText.text;
                    }
                  } else {
                    _sexo = '';
                  }
                  if (data_nasc.text.length == 10) {
                    if (telefone.text.length >= 13) {
                      //enviar dados
                      print(telefone.text);
                      user.changeCpf(cpf.text);
                      user.changeDataNasc(data_nasc.text);
                      user.changeSexo(_sexo);
                      user.changeTelefone(telefone.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CadastroScreen3(user: user)));
                    } else {
                      mensagem = 'Insira um Telefone válido!';
                    }
                  } else {
                    mensagem = 'Insira uma Data válida!';
                  }
                } else {
                  mensagem = 'Insira um CPF válido!';
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
        ]),
      ),
    );
  }
}
