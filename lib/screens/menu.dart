import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  @override
  Menu createState() => Menu();
}

class Menu extends State {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(432, 816),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //CORPO DA TELA
          body: Container(
            child: ListView(
              children: <Widget>[
                MenuPerfil(),
                MenuLista(),
                SizedBox(
                  height: 213.h,
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                ),
                MenuSair(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 25.r,
        left: 25.r,
        right: 25.r,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple[600],
      ),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuInferiorScreen()),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
              ),
              Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configuracoes()),
                  );*/
                },
                icon: Icon(Icons.settings, size: 30),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(' '),
              Container(
                width: 170.w,
                height: 170.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: NetworkImage(
                            'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg'),
                      ),
                    ),
                  ),
                ),
              ),
              Text(' '),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(' '),
              Text(
                'Ver Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text(' '),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
}

class MenuLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 27.r,
        left: 25.r,
        right: 25.r,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeusAnuncios()),
                );*/
              },
              child: Text(
                'Meus Anúncios',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CriarAnuncio()),
                );*/
              },
              child: Text(
                'Criar Anúncio',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeusInteresses()),
                );*/
              },
              child: Text(
                'Meus Interesses',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuSair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.r,
        left: 25.r,
        right: 25.r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            color: Colors.red,
            onPressed: () {
              FirestoreService firestore = new FirestoreService();
              firestore.SignOut();
            },
            icon: Icon(Icons.exit_to_app, size: 40),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 5.r,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 7.r),
            child: TextButton(
              child: Text(
                'Sair',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                FirestoreService firestore = new FirestoreService();
                firestore.SignOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
