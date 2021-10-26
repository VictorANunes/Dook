import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/screens/livro/pagina_livro.dart';
import 'package:dook/screens/livro/pagina_meu_livro.dart';
import 'package:dook/screens/notificacoes.dart';
import 'package:dook/screens/pesquisa.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcervoScreen extends StatefulWidget {
  @override
  Acervo createState() => Acervo();
}

class Acervo extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 18.r,
          left: 19.r,
          right: 20.r,
        ),
        child: ListView(
          children: [
            AcervoCabecalho(),
            SizedBox(
              height: 10.h,
            ),
            AcervoCorpo() //Ação, Romance, Suspense, Ficção, Educação
          ],
        ),
      ),
    );
  }
}

class AcervoCabecalho extends StatelessWidget {
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

class AcervoCorpo extends StatelessWidget {
  FirestoreService firestore = FirestoreService();
  List<String> generos = [
    'Ação',
    'Aventura',
    'Terror',
    'Infantil',
    'Suspense',
    'Educação',
    'Material Acadêmico',
    'Infanto-Juvenil',
    'Romance',
    'Romance Biográfico',
    'Romance Epistolar',
    'Romance Histórico',
    'Romance Psicólogo',
    'Drama',
    'Novela',
    'Conto',
    'Crônica',
    'Ensaio',
    'Poesia',
    'Carta',
    'Biografia',
    'Memórias',
    'Graphic Novel',
    'História em Quadrinhos (HQ)',
    'Lad-Lit',
    'Literatura fantástica',
    'Literatura Infantil',
    'Literatura Infanto-juvenil',
    'New Adult',
    'Realismo Mágico',
    'Terror',
    'Thriller ou suspense',
    'Conspiração',
    'Época',
    'Jurídico',
    'Médico',
    'Policial',
    'Psicológico',
    'Romântico',
    'Ficção'
  ];

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: generos.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder(
            future: firestore.getExemplaresGeneros([generos[index]]),
            builder: (context, exemplares) {
              if (exemplares.hasData) {
                return Container(
                  width: 340.w,
                  height: 260.h,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            generos[index],
                            style: TextStyle(
                                fontSize: 27.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
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
                          itemBuilder: (BuildContext context, int index2) {
                            return StreamBuilder(
                              stream: firestore
                                  .getExemplar(exemplares.data[index2]),
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
                                                firestore.getEmail()) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      LivroScreen(
                                                          exemplar: exemplares
                                                              .data[index2]),
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
                                                              .data[index2]),
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
                                                          exemplar.data.capa),
                                                    ),
                                                  ),
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
                                                    textAlign: TextAlign.center,
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
                        ),
                      ),
                    ],
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
  }
}
