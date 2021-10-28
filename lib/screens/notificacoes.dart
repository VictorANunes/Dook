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
                    fontSize: 35.sp,
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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 690.h,
      //color: Colors.yellow,
      child: StreamBuilder(
        stream: firestore.getNotification(firestore.getEmail()),
        builder: (BuildContext context, AsyncSnapshot not) {
          if (not.hasData) {
            return ListView.separated(
              itemCount: not.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(not.data.docs[index]['titulo'],
                      style: TextStyle(
                        fontSize: 20.sp,
                      )),
                  subtitle: Text(not.data.docs[index]['msg'],
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                  leading: Container(
                    child: Icon(
                      Icons.ac_unit,
                      color: Colors.black,
                    ),
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
