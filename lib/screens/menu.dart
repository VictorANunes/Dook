import 'package:dook/models/user_models.dart';
import 'package:dook/screens/anuncio/criar_anuncio_1.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/screens/meus_anuncios.dart';
import 'package:dook/screens/perfil/meuperfil.dart';
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
                  height: 205.h,
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
  FirestoreService firestore = new FirestoreService();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.r,
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
                icon: Image.asset(
                  'assets/images/icons/voltarbranco.png',
                  height: 25.h,
                  width: 25.w,
                ),
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
                icon: Image.asset(
                  'assets/images/icons/settingsbranco.png',
                  height: 27.h,
                  width: 27.w,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.0.r),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(' '),
              StreamBuilder(
                  stream: firestore.getDadosUsuario(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Users> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return new Center(child: new CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return Container(
                        width: 170.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot.data.url),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 170.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.r),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg'),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
              Text(' '),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(3.0.r),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(' '),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MeuPerfilScreen()));
                  },
                  child: Text(
                    'Ver Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      decoration: TextDecoration.underline,
                    ),
                  )),
              Text(' '),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(4.0.r),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeusAnunciosScreen()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CriarAnuncio1Screen()),
                );
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
                  MaterialPageRoute(
                      builder: (context) => CriarAnuncio1Screen()),
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
        top: 3.r,
        left: 25.r,
        right: 25.r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 60.w,
            height: 60.h,
            child: IconButton(
              color: Colors.red,
              onPressed: () {
                FirestoreService firestore = new FirestoreService();
                firestore.SignOut();
              },
              icon: Image.asset(
                'assets/images/icons/sair.png',
                height: 42.h,
                width: 42.w,
              ),
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
