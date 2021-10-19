import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/chat_models.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/provider/chat_provider.dart';
import 'package:dook/screens/notificacoes.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
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
              height: 20.h,
            ),
            IntGenerosInteresse(),
            IntListaDesejos(),
            IntMeusAnuncios(),
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
                                builder: (BuildContext context) =>
                                    PesquisaScreen(
                                        pesquisa:
                                            pesquisa.text.toLowerCase())));
                      }
                    }),
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
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 245.h,
      child: Column(
        children: <Widget>[
          Text(
            'Livros que Podem te Interessar',
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 195.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://livrariascuritiba.vteximg.com.br/arquivos/ids/1663114-1000-1000/LV417866.jpg?v=636815454000200000'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          // color: Colors.blue,
                          height: 50.h,
                          child: Text(
                            'Harry Potter',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 135.h,
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/61hH5E8xHZL.jpg'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          height: 50.h,
                          child: Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
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
      height: 265.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Lista de Desejos',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: IconButton(
                icon: Image.asset('assets/images/icons/add.png',
                    height: 30.h, width: 30.w),
                onPressed: () {
                  FirestoreService firestore = FirestoreService();
                  ChatProvider chat = ChatProvider();
                  chat.changeDoador("luis@gmail.com");
                  chat.changeReceptor("b@gmail.com");
                  chat.changeExemplar("1");
                  chat.changeData(DateTime.now().millisecondsSinceEpoch);
                  chat.saveChat();

                  var listaEspera = ['b@gmail.com'];
                  //pegar lista
                  firestore.updateListaEspera(chat.exemplar, listaEspera);
                },
              ),
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: StreamBuilder(
              stream: firestore.getDadosUsuario(),
              builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
                List<String> livros = [];
                if (usuario.hasData) {
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
                  //print(livros);
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 195.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: livros.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StreamBuilder(
                          stream: firestore.getObraWithTitulo(livros[index]),
                          builder: (BuildContext context, AsyncSnapshot obra) {
                            if (obra.hasData) {
                              return Container(
                                height: 195.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: obra.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return StreamBuilder(
                                      stream: firestore.getExemplarWithIsbn(
                                          obra.data.docs[index].id),
                                      builder: (BuildContext context,
                                          AsyncSnapshot exemplar) {
                                        if (exemplar.hasData) {
                                          return Container(
                                            height: 195,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  exemplar.data.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  width: 135.w,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 135.h,
                                                        child: Image.network(
                                                            exemplar.data.docs[
                                                                        index]
                                                                    ['fotos']
                                                                ['capa']),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Container(
                                                          // color: Colors.blue,
                                                          height: 50.h,
                                                          child: Text(
                                                            obra.data
                                                                    .docs[index]
                                                                ['titulo'],
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),

          /*Container(
            height: 195.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://livrariascuritiba.vteximg.com.br/arquivos/ids/1663114-1000-1000/LV417866.jpg?v=636815454000200000'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          // color: Colors.blue,
                          height: 50.h,
                          child: Text(
                            'Harry Potter',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 135.h,
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/61hH5E8xHZL.jpg'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          height: 50.h,
                          child: Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

class IntMeusAnuncios extends StatelessWidget {
  FirestoreService firestore = new FirestoreService();
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 265.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Meus Anúncios',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: IconButton(
                icon: Image.asset('assets/images/icons/add.png',
                    height: 30.h, width: 30.w),
                onPressed: () async {},
              ),
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 195.h,
            child: StreamBuilder(
                stream: firestore.getMeusAnuncios(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Exemplar>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 135.w,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 135.h,
                                  child:
                                      Image.network(snapshot.data[index].capa),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                    // color: Colors.blue,
                                    height: 50.h,
                                    child: StreamBuilder(
                                      stream: firestore
                                          .getObra(snapshot.data[index].isbn),
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
                                          return Text('oi');
                                        }
                                      },
                                    )),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Text('oi');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
