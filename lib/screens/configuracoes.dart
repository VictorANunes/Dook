import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfiguracoesScreen extends StatefulWidget {
  @override
  Configuracoes createState() => Configuracoes();
}

class Configuracoes extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 40.r,
          //left: 25.r,
          //right: 25.r,
        ),
        child: Column(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 35.h,
            ),
            Menu(),
            SizedBox(
              height: 180.h,
            ),
            Divider(
              height: 0,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              //color: Colors.red,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60.w,
                  height: 60.h,
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      //FirestoreService firestore = new FirestoreService();
                      //firestore.SignOut();
                    },
                    icon: Icon(Icons.delete_outline_rounded, size: 42),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 0.r,
                  ),
                ),
                Container(
                  child: TextButton(
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      //FirestoreService firestore = new FirestoreService();
                      //firestore.SignOut();
                    },
                  ),
                ),
              ],
            ),
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
      padding: EdgeInsets.only(
        left: 25.r,
        right: 25.r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              //telaCriarAnuncio2();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            ),
          ),
          Text(
            'Configurações',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.sp,
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
    return Column(
      
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 25.r,
            right: 25.r,
          ),
          //height: 60.h,
          decoration: new BoxDecoration(color: Colors.grey[350]),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Notificações',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 25.r,
            right: 25.r,
          ),
          //height: 60.h,
          decoration: new BoxDecoration(color: Colors.grey[350]),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.task_outlined,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Termos de Uso',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 25.r,
            right: 25.r,
          ),
          //height: 60.h,
          decoration: new BoxDecoration(color: Colors.grey[350]),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.content_paste_rounded,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Política de Privacidade',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 25.r,
            right: 25.r,
          ),
          //height: 60.h,
          decoration: new BoxDecoration(color: Colors.grey[350]),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.help_outline_rounded,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Suporte',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Container(
          padding: EdgeInsets.only(
            left: 25.r,
            right: 25.r,
          ),
          //height: 60.h,
          decoration: new BoxDecoration(color: Colors.grey[350]),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline_rounded,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Sobre',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
