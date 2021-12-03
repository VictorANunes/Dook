import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificacaoScreen extends StatefulWidget {
  @override
  Notificacao createState() => Notificacao();
}

class Notificacao extends State {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 35.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            NotificacaoCabecalho(),
            SizedBox(
              height: 15.h,
            ),
            NotificacaoCorpo()
          ],
        ),
      ),
    );
  }
}

class NotificacaoCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
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
              child: Text('Notificações',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 35.ssp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              width: 220.w,
            ),
            Container(
              width: 70.w,
            ),
          ]),
        ],
      ),
    );
  }
}

class NotificacaoCorpo extends StatelessWidget {
  FirestoreService firestore = FirestoreService();
  List<DocumentSnapshot> notify = <DocumentSnapshot>[];
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 690.h,
      child: FutureBuilder(
        future: firestore.getNotification(firestore.getEmail()),
        builder: (BuildContext context, AsyncSnapshot not) {
          if (not.hasData) {
            notify = not.data.docs;
            notify.sort((a, b) => b['data'].compareTo(a['data']));
            return ListView.separated(
              itemCount: notify.length,
              itemBuilder: (BuildContext context, int index) {
                Widget icone = Image.asset(
                  'assets/images/icons/voltar.png',
                  height: 25.h,
                  width: 25.w,
                );
                if (notify[index]['tipoMensagem'] == 'Lista Espera') {
                  icone = Image.asset(
                    'assets/images/icons/acervo.png',
                    height: 25.h,
                    width: 25.w,
                  );
                } else {
                  if (notify[index]['tipoMensagem'] == 'Mensagem') {
                    icone = Image.asset(
                      'assets/images/icons/chat.png',
                      height: 25.h,
                      width: 25.w,
                    );
                  } else {
                    if (notify[index]['tipoMensagem'] == 'Livro Enviado' ||
                        notify[index]['tipoMensagem'] == 'Livro Recebido') {
                      icone = Image.asset(
                        'assets/images/icons/pin.png',
                        height: 25.h,
                        width: 25.w,
                      );
                    } else {
                      if (notify[index]['tipoMensagem'] == 'Livro Disponivel') {
                        icone = Image.asset(
                          'assets/images/icons/acervo.png',
                          height: 25.h,
                          width: 25.w,
                        );
                      }
                    }
                  }
                }
                return ListTile(
                  title: Text(notify[index]['titulo'],
                      style: TextStyle(
                        fontSize: 20.ssp,
                      )),
                  subtitle: Text(notify[index]['msg'],
                      style: TextStyle(
                        fontSize: 14.ssp,
                      )),
                  leading: Container(
                    child: icone,
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0,
                  thickness: 1.1,
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
/*ListView.separated(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('$index sheep'),
    );
  },
  separatorBuilder: (context, index) {
    return Divider();
  },
) */
