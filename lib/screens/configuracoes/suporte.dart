import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class SuporteScreen extends StatefulWidget {
  @override
  Suporte createState() => Suporte();
}

class Suporte extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 30.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 35.h,
            ),
            Menu(),
          ],
        ),
      ),
    );
  }
}

class Superior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              //telaCriarAnuncio2();
            },
            icon: Image.asset(
              'assets/images/icons/voltar.png',
              height: 25.h,
              width: 25.w,
            ),
          ),
          Text(
            'Suporte',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.ssp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 30.r,
            ),
          ),
        ],
      ),
    );
  }
}

TextEditingController duvida = TextEditingController();

class Menu extends StatelessWidget {
  @override
  void showAlertDialog1(BuildContext context) {
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      contentPadding: EdgeInsets.only(top: 15.r),
      content: Container(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/icons/aceitar.png',
                  color: Colors.green,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Sucesso',
              style: TextStyle(fontSize: 27.ssp),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, right: 20.r),
              child: Text(
                'Sua Mensagem foi enviada para o suporte, assim que possível iremos responder através do seu e-mail cadastrado no App.',
                style: TextStyle(fontSize: 15.ssp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 6.r, bottom: 6.r),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MenuInferiorScreen()),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 17.ssp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Future sendEmail(String mensagem) async {
    FirestoreService firestore = FirestoreService();
    var result = await FirebaseFirestore.instance
        .collection('Usuario')
        .doc(firestore.getEmail())
        .get();

    String nome = result.data()['nome'];
    String email = result.id;

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_k3iq734',
        'template_id': 'template_p63c8wk',
        'user_id': 'user_pKkUosoIGJHJGifFvwCIM',
        'template_params': {
          'user_name': nome,
          'user_email': email,
          'message': mensagem,
        }
      }),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              'Deixe aqui a sua dúvida, problema ou bug encontrado, que nosso suporte irá te responder através do e-mail cadastrado no App.',
              style: TextStyle(fontSize: 18.ssp)),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 200.h,
          child: TextFormField(
            controller: duvida,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              labelText: "Escreva Aqui",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.ssp,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300.h,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple[600],
            minimumSize: Size(382.h, 55.h),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          onPressed: () async {
            showAlertDialog1(context);
            sendEmail(duvida.text);
            duvida.text = '';
          },
          child: Text(
            'Enviar',
            style: TextStyle(fontSize: 18.ssp),
          ),
        ),
      ],
    );
  }
}
