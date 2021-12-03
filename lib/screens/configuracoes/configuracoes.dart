import 'package:dook/screens/configuracoes/notificacao.dart';
import 'package:dook/screens/configuracoes/privacidade.dart';
import 'package:dook/screens/configuracoes/sobre.dart';
import 'package:dook/screens/configuracoes/suporte.dart';
import 'package:dook/screens/configuracoes/termos_uso.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class ConfiguracoesScreen extends StatefulWidget {
  @override
  Configuracoes createState() => Configuracoes();
}

class Configuracoes extends State {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 30.r,
        ),
        child: Column(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 35.h,
            ),
            Menu(),
            SizedBox(
              height: 190.h,
            ),
            Divider(
              height: 0,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              //color: Colors.red,
            ),
            Container(
              padding: EdgeInsets.only(
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
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/icons/lixeira verm.png',
                        height: 40.h,
                        width: 40.w,
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
                        'Excluir Conta',
                        style: TextStyle(
                          fontSize: 24.ssp,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        firestore.removeUser();
                      },
                    ),
                  ),
                ],
              ),
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
        top: 30.r,
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
            icon: Image.asset(
              'assets/images/icons/voltar.png',
              height: 25.h,
              width: 25.w,
            ),
          ),
          Text(
            'Configurações',
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
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificacaoScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            height: 60.h,
            decoration: new BoxDecoration(color: Colors.grey[350]),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificacaoScreen()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificacaoScreen()),
                          );
                        },
                        icon: Image.asset(
                          'assets/images/icons/notificação.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                      Text(
                        'Notificações',
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificacaoScreen()),
                      );
                    },
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/icons/voltar.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermosUsoScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            height: 60.h,
            decoration: new BoxDecoration(color: Colors.grey[350]),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermosUsoScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermosUsoScreen()),
                          );
                        },
                        icon: Image.asset(
                          'assets/images/icons/termos.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                      Text(
                        'Termos de Uso',
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermosUsoScreen()),
                      );
                    },
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/icons/voltar.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacidadeScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            height: 60.h,
            decoration: new BoxDecoration(color: Colors.grey[350]),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacidadeScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacidadeScreen()),
                          );
                        },
                        icon: Image.asset(
                          'assets/images/icons/politicapriv.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                      Text(
                        'Política de Privacidade',
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacidadeScreen()),
                      );
                    },
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/icons/voltar.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuporteScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            height: 60.h,
            decoration: new BoxDecoration(color: Colors.grey[350]),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuporteScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuporteScreen()),
                          );
                        },
                        icon: Image.asset(
                          'assets/images/icons/suporte.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                      Text(
                        'Suporte',
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuporteScreen()),
                      );
                    },
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/icons/voltar.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SobreScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            height: 60.h,
            decoration: new BoxDecoration(color: Colors.grey[350]),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SobreScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SobreScreen()),
                          );
                        },
                        icon: Image.asset(
                          'assets/images/icons/sobre.png',
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                      Text(
                        'Sobre',
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SobreScreen()),
                      );
                    },
                    icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Image.asset(
                        'assets/images/icons/voltar.png',
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
