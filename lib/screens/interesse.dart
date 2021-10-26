import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/anuncio/criar_anuncio_1.dart';
import 'package:dook/screens/livro/pagina_livro.dart';
import 'package:dook/screens/livro/pagina_meu_livro.dart';
import 'package:dook/screens/notificacoes.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/pesquisa.dart';

class InteresseScreen extends StatefulWidget {
  @override
  Interesse createState() => Interesse();
}

class Interesse extends State {
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
        children: <Widget>[
          Container(
            width: 340.w,
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
                  fontSize: 16.sp,
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
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: 40.w,
            padding: EdgeInsets.only(bottom: 10.r),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.deepPurple[600],
                size: 40,
              ),
              onPressed: () {
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
    return Container(
      width: 340.w,
      height: 260.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Text(
              'Livros que Podem te Interessar',
              style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 210.h,
            alignment: Alignment.centerLeft,
            child: StreamBuilder(
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
                  List<String> generos = [];

                  if (usuario.data.generos1 != '') {
                    generos.add(usuario.data.generos1);
                  }
                  if (usuario.data.generos2 != '') {
                    generos.add(usuario.data.generos2);
                  }
                  if (usuario.data.generos3 != '') {
                    generos.add(usuario.data.generos3);
                  }
                  if (usuario.data.generos4 != '') {
                    generos.add(usuario.data.generos4);
                  }
                  if (usuario.data.generos5 != '') {
                    generos.add(usuario.data.generos5);
                  }

                  if (!generos.isEmpty) {
                    return FutureBuilder(
                      future: firestore.getExemplaresGeneros(generos),
                      builder: (context, exemplares) {
                        if (exemplares.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.deepPurple[600],
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          );
                        }
                        if (exemplares.hasData) {
                          return ListView.builder(
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
                                          return GestureDetector(
                                            onTap: () {
                                              if (exemplar.data.criador !=
                                                  usuario.data.email) {
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
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MeuLivroScreen(
                                                            exemplar: exemplares
                                                                .data[index]),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 15.r),
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
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IntListaDesejos extends StatelessWidget {
  FirestoreService firestore = FirestoreService();
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 275.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Lista de Desejos',
                style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: IconButton(
                icon: Image.asset('assets/images/icons/add.png',
                    height: 30.h, width: 30.w),
                onPressed: () {
                  //Ir para alterar lista de desejos
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
            child: StreamBuilder(
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
                  List<String> livros = [];

                  if (usuario.data.livros1 != '') {
                    livros.add(usuario.data.livros1);
                  }
                  if (usuario.data.livros2 != '') {
                    livros.add(usuario.data.livros2);
                  }
                  if (usuario.data.livros3 != '') {
                    livros.add(usuario.data.livros3);
                  }
                  if (usuario.data.livros4 != '') {
                    livros.add(usuario.data.livros4);
                  }
                  if (usuario.data.livros5 != '') {
                    livros.add(usuario.data.livros5);
                  }

                  if (!livros.isEmpty) {
                    return FutureBuilder(
                        future: firestore.getExemplaresLivros(livros),
                        builder: (context, exemplares) {
                          if (exemplares.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.deepPurple[600],
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            );
                          }
                          if (exemplares.hasData) {
                            return ListView.builder(
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
                                        stream: firestore
                                            .getObra(exemplar.data.isbn),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Obra> obra) {
                                          if (obra.hasData) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (exemplar.data.criador !=
                                                    usuario.data.email) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          LivroScreen(
                                                              exemplar:
                                                                  exemplares
                                                                          .data[
                                                                      index]),
                                                    ),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MeuLivroScreen(
                                                              exemplar:
                                                                  exemplares
                                                                          .data[
                                                                      index]),
                                                    ),
                                                  );
                                                }
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
                                                            fontSize: 17.sp,
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
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        });
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IntMeusAnuncios extends StatelessWidget {
  FirestoreService firestore = new FirestoreService();
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 275.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Meus Anúncios',
                style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w500),
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
                              CriarAnuncio1Screen()));
                },
              ),
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 210.h,
            child: StreamBuilder(
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
                    return ListView.builder(
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
                                              fontSize: 17.sp,
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
                    );
                  } else {
                    return Text('');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
