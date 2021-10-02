import 'package:dook/models/user_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeuPerfilScreen extends StatefulWidget {
  @override
  MeuPerfil createState() => MeuPerfil();
}

class MeuPerfil extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            MeuPerfilCabecalho(),
            MeuPerfilCorpo(),
          ],
        ),
      ),
    );
  }
}

class MeuPerfilCabecalho extends StatelessWidget {
  FirestoreService firestore = new FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.deepPurple[600]),
            height: 220.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  alignment: Alignment.centerLeft,
                ),
                width: 90.w,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    //Editar Perfil
                  },
                  icon: Icon(Icons.edit_outlined),
                  alignment: Alignment.centerRight,
                ),
                width: 90.w,
              ),
            ],
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
                        margin: EdgeInsets.symmetric(vertical: 100.0.r),
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
                          color: Colors.grey[600],
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 270.0),
            width: 431.w,
            height: 120.h,
            //color: Colors.yellow,
            child: Container(
              padding: EdgeInsets.only(
                top: 10.r,
                left: 25.r,
                right: 25.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      stream: firestore.getDadosUsuario(),
                      builder:
                          (BuildContext context, AsyncSnapshot<Users> usuario) {
                        if (usuario.hasData) {
                          String nome = usuario.data.nome;
                          List<String> nome2 = nome.split(" ");
                          String nome3 =
                              nome2[0] + " " + nome2[nome2.length - 1];

                          return Column(
                            children: <Widget>[
                              Text(nome3,
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold)),
                              Text(usuario.data.cidade + ", " + usuario.data.uf,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0.r),
                                  child: RatingBarIndicator(
                                    rating: 4,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.deepPurple[600],
                                    ),
                                    itemCount: 5,
                                    itemSize: 27.0.sp,
                                    direction: Axis.horizontal,
                                  )),
                            ],
                          );
                        } else {
                          return Text('');
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeuPerfilCorpo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
