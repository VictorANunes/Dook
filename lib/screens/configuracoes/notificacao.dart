import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toggle_switch/toggle_switch.dart';

class NotificacaoScreen extends StatefulWidget {
  @override
  Notificacao createState() => Notificacao();
}

class Notificacao extends State {
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
            'Notificações',
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

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return StreamBuilder(
        stream: firestore.getDadosUsuario(),
        builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
          if (usuario.hasData) {
            var not = 0;
            if (usuario.data.notificacao) {
              not = 0;
            } else {
              not = 1;
            }
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notificações',
                      style: TextStyle(fontSize: 22.sp),
                    ),
                    ToggleSwitch(
                      minWidth: 40.w,
                      minHeight: 30.h,
                      initialLabelIndex: not,
                      cornerRadius: 15,
                      activeFgColor: Colors.grey[300],
                      inactiveBgColor: Colors.grey[300],
                      inactiveFgColor: Colors.grey[300],
                      totalSwitches: 2,
                      labels: ['On', 'Off'],
                      customTextStyles: [
                        TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.ssp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.ssp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                      activeBgColors: [
                        [Colors.deepPurple[200]],
                        [Colors.deepPurple[200]]
                      ],
                      borderWidth: 1,
                      borderColor: [Colors.grey[300]],
                      onToggle: (index) {
                        if (index == 0) {
                          firestore.updateNotificacao(true);
                        } else {
                          firestore.updateNotificacao(false);
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
