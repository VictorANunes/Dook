import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/anuncio/criar_anuncio_1.dart';
import 'package:dook/screens/chat/avaliacao.dart';
import 'package:dook/screens/livro/pagina_livro.dart';
import 'package:dook/screens/livro/pagina_meu_livro.dart';
import 'package:dook/screens/meus_interesses/meus_interesses1.dart';
import 'package:dook/screens/notificacoes.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/pesquisa.dart';
import 'package:another_flushbar/flushbar.dart';

class InteresseScreen extends StatefulWidget {
  @override
  Interesse createState() => Interesse();
}

class Interesse extends State {
  void initState() {
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseMessaging _fcm = FirebaseMessaging();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Flushbar(
          icon: Icon(Icons.notifications, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: message['notification']['title'],
          message: message['notification']['body'],
          onTap: (_) {
            //levar para tela de notificações
          },
          padding: EdgeInsets.all(24),
          flushbarPosition: FlushbarPosition.TOP,
          duration: Duration(seconds: 4),
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          barBlur: 20,
          backgroundColor: Colors.black.withOpacity(0.5),
        ).show(context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = new FirestoreService();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 18.r,
          left: 19.r,
          right: 20.r,
        ),
        child: ListView(
          children: <Widget>[
            IntCabecalho(),
            SizedBox(
              height: 10.h,
            ),
            Container(
              child: IntGenerosInteresse(),
            ),
            Container(
              child: IntListaDesejos(),
            ),
            Container(
              child: IntMeusAnuncios(),
            ),
          ],
        ),
      ),
    );
  }
}

class IntCabecalho extends StatelessWidget {
  @override
  final pesquisa = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 335.w,
            child: TextFormField(
              cursorColor: Colors.deepPurple[600],
              controller: pesquisa,
              decoration: InputDecoration(
                hasFloatingPlaceholder: false,
                contentPadding: EdgeInsets.only(
                  top: 15.r,
                  bottom: 15.r,
                  left: 15.r,
                  right: 15.r,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.deepPurple[600])),
                labelText: "Pesquisar",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.ssp,
                ),
                suffixIcon: IconButton(
                  //ou prefix
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.deepPurple[600],
                  ),
                  onPressed: () {
                    if (pesquisa.text != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PesquisaScreen(
                            pesquisa: pesquisa.text.toLowerCase(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 55.w,
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Image.asset(
                'assets/images/icons/notificacaoroxo.png',
                height: 65.h,
                width: 50.w,
              ),
              onPressed: () {
                /*NotificationService ns = NotificationService();
                ns.sendNotification(
                    'teste', 'teste', 'luis@gmail.com', 'teste');*/
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NotificacaoScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IntGenerosInteresse extends StatelessWidget {
  FirestoreService firestore = FirestoreService();

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.getDadosUsuario(),
      builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
        if (usuario.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (usuario.hasData) {
          List<String> generos = usuario.data.generos;

          if (!generos.isEmpty) {
            return FutureBuilder(
              future: firestore.getExemplaresGeneros(generos),
              builder: (context, exemplares) {
                if (exemplares.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple[600],
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }
                if (exemplares.hasData) {
                  return Container(
                    width: 340.w,
                    height: 275.h,
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(
                            'Livros que Podem te Interessar',
                            style: TextStyle(
                                fontSize: 27.ssp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ]),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          height: 210.h,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: exemplares.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StreamBuilder(
                                stream: firestore
                                    .getExemplar(exemplares.data[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Exemplar> exemplar) {
                                  if (exemplar.hasData) {
                                    return StreamBuilder(
                                      stream:
                                          firestore.getObra(exemplar.data.isbn),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Obra> obra) {
                                        if (obra.hasData) {
                                          if (exemplar.data.criador !=
                                              usuario.data.email) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        LivroScreen(
                                                            exemplar: exemplares
                                                                .data[index]),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 15.r),
                                                width: 125.w,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 145.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.r)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  exemplar.data
                                                                      .capa))),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Container(
                                                      height: 50.h,
                                                      child: Text(
                                                        obra.data.titulo,
                                                        style: TextStyle(
                                                            fontSize: 17.ssp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: 340.w,
                    height: 150.h,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Livros que Podem te Interessar',
                              style: TextStyle(
                                  fontSize: 27.ssp,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            'No momento não temos nenhum livro cadastrado que seja do seu gênero de interesse!',
                            style: TextStyle(
                                fontSize: 19.ssp, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Container(
              width: 340.w,
              height: 150.h,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Livros que Podem te Interessar',
                        style: TextStyle(
                            fontSize: 27.ssp, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text(
                      'Nenhum gênero de interesse cadastrado!',
                      style: TextStyle(
                          fontSize: 20.ssp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      'Cadastre até 5 gêneros de interesse (Opção Meus Interesses no Menu) para que possamos mostrar livros de seu interesse!',
                      style: TextStyle(fontSize: 15.ssp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}

class IntListaDesejos extends StatelessWidget {
  FirestoreService firestore = FirestoreService();
  Widget build(BuildContext contexto) {
    return StreamBuilder(
      stream: firestore.getDadosUsuario(),
      builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
        if (usuario.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (usuario.hasData) {
          List<String> livros = usuario.data.livros;
          List<String> generos = usuario.data.generos;

          if (!livros.isEmpty) {
            return FutureBuilder(
              future: firestore.getExemplaresLivros(livros),
              builder: (context, exemplares) {
                if (exemplares.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple[600],
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }
                if (exemplares.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.h,
                    child: Column(
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Lista de Desejos',
                                  style: TextStyle(
                                      fontSize: 27.ssp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/images/icons/add.png',
                                      height: 30.h,
                                      width: 30.w),
                                  onPressed: () {
                                    //Ir para alterar lista de desejos
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MeusInteresses1Screen(
                                                generos2: generos,
                                                livros2: livros),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          height: 210.h,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: exemplares.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StreamBuilder(
                                stream: firestore
                                    .getExemplar(exemplares.data[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Exemplar> exemplar) {
                                  if (exemplar.hasData) {
                                    return StreamBuilder(
                                      stream:
                                          firestore.getObra(exemplar.data.isbn),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Obra> obra) {
                                        if (obra.hasData) {
                                          if (exemplar.data.criador !=
                                              usuario.data.email) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        LivroScreen(
                                                            exemplar: exemplares
                                                                .data[index]),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 15.r),
                                                width: 125.w,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 145.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.r)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  exemplar.data
                                                                      .capa))),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Container(
                                                      height: 50.h,
                                                      child: Text(
                                                        obra.data.titulo,
                                                        style: TextStyle(
                                                            fontSize: 17.ssp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: 340.w,
                    height: 150.h,
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Lista de Desejos',
                                style: TextStyle(
                                    fontSize: 27.ssp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: Image.asset('assets/images/icons/add.png',
                                    height: 30.h, width: 30.w),
                                onPressed: () {
                                  //Ir para alterar lista de desejos
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MeusInteresses1Screen(
                                              generos2: generos,
                                              livros2: livros),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            'No momento não temos nenhum livro cadastrado que seja da sua lista de desejos!',
                            style: TextStyle(
                                fontSize: 19.ssp, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Container(
              width: 340.w,
              height: 150.h,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Lista de Desejos',
                          style: TextStyle(
                              fontSize: 27.ssp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Image.asset('assets/images/icons/add.png',
                              height: 30.h, width: 30.w),
                          onPressed: () {
                            //Ir para alterar lista de desejos
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MeusInteresses1Screen(
                                        generos2: generos, livros2: livros),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text(
                      'Nenhum livro de interesse cadastrado!',
                      style: TextStyle(
                          fontSize: 20.ssp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      'Cadastre até 5 livros de interesse (Opção Meus Interesses no Menu) para que possamos mostrar livros da sua lista de desejo!',
                      style: TextStyle(fontSize: 15.ssp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}

class IntMeusAnuncios extends StatelessWidget {
  FirestoreService firestore = new FirestoreService();
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.getMeusAnuncios(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.docs.length != 0) {
            return Container(
              width: 340.w,
              height: 300.h,
              child: Column(
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Meus Anúncios',
                            style: TextStyle(
                                fontSize: 27.ssp, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Image.asset('assets/images/icons/add.png',
                                height: 30.h, width: 30.w),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CriarAnuncio1Screen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 210.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MeuLivroScreen(
                                        exemplar: snapshot.data.docs[index].id),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 15.r),
                            width: 125.w,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 145.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data
                                              .docs[index]['fotos']['capa']))),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  height: 50.h,
                                  child: StreamBuilder(
                                    stream: firestore.getObra(
                                        snapshot.data.docs[index]['isbn']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Obra> obra) {
                                      if (obra.hasData) {
                                        return Text(
                                          obra.data.titulo,
                                          style: TextStyle(
                                              fontSize: 17.ssp,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return Text('');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: 340.w,
              height: 150.h,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Meus Anuncios',
                          style: TextStyle(
                              fontSize: 27.ssp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Image.asset('assets/images/icons/add.png',
                              height: 30.h, width: 30.w),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CriarAnuncio1Screen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text(
                      'Você ainda não criou nenhum anuncio para doação de livros!',
                      style: TextStyle(
                          fontSize: 19.ssp, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Text('');
        }
      },
    );
  }
}
