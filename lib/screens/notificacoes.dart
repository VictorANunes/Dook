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
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                alignment: Alignment.centerLeft,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 690.h,
      //color: Colors.yellow,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text('Novo Interessado',
                  style: TextStyle(
                    fontSize: 20.sp,
                  )),
              subtitle: Text('aaaaaaaaaaaaaaaaaaaaaa',
                  style: TextStyle(
                    fontSize: 14.sp,
                  )),
              leading: Container(
                child: Icon(
                  Icons.ac_unit,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                '8m',
                style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
              ),
              onTap: () {
                NotificationService nf = new NotificationService();
                nf.teste();
              },
            ),
            ListTile(
              title: Text('Novo Interessado',
                  style: TextStyle(
                    fontSize: 20.sp,
                  )),
              subtitle: Text('aaaaaaaaaaaaaaaaaaaaaa',
                  style: TextStyle(
                    fontSize: 14.sp,
                  )),
              leading: Container(
                child: Icon(
                  Icons.ac_unit,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                '8m',
                style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
              ),
            ),
          ],
        ).toList(),
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
