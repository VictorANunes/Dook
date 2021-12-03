import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dook/screens/livro/editar_livro.dart';

class MeuLivroScreen extends StatefulWidget {
  var exemplar;
  MeuLivroScreen({this.exemplar});
  @override
  MeuLivro createState() => MeuLivro(exemplar: exemplar);
}

List<String> condicao = new List(5);

class MeuLivro extends State {
  var exemplar;
  MeuLivro({this.exemplar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Superior(
                exemplar: exemplar,
              ),
              SizedBox(
                height: 35.h,
              ),
              Carrossel(
                exemplar: exemplar,
              ),
              SizedBox(
                height: 30.h,
              ),
              InfoLivro(
                exemplar: exemplar,
              ),
              SizedBox(
                height: 30.h,
              ),
              Condicao(
                exemplar: exemplar,
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Superior extends StatelessWidget {
  var exemplar;
  Superior({this.exemplar});
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return StreamBuilder(
      stream: firestore.getExemplar(exemplar),
      builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
        if (exemplar2.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (exemplar2.hasData) {
          condicao[0] = exemplar2.data.resp1;
          condicao[1] = exemplar2.data.resp2;
          condicao[2] = exemplar2.data.resp3;
          condicao[3] = exemplar2.data.resp4;
          condicao[4] = exemplar2.data.resp5;
          //print(condicao);
          if (exemplar2.data.status != 'aberto') {
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/icons/voltar.png',
                      height: 25.h,
                      width: 25.w,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    'Livro',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 33.ssp,
                    ),
                  ),
                  Container(
                    width: 47.w,
                  )
                ],
              ),
            );
          } else {
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/icons/voltar.png',
                      height: 25.h,
                      width: 25.w,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    'Livro',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 33.ssp,
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditarLivroScreen(
                                    exemplar: exemplar,
                                    condicao: condicao,
                                  )));
                    },
                    icon: Image.asset(
                      'assets/images/icons/edit.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    alignment: Alignment.centerRight,
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

class Carrossel extends StatelessWidget {
  var exemplar;
  Carrossel({this.exemplar});
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();

    return Container(
      child: StreamBuilder(
        stream: firestore.getExemplar(exemplar),
        builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
          if (exemplar2.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple[600],
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          if (exemplar2.hasData) {
            return Column(
              children: <Widget>[
                // Carrossel de imagens
                CarouselSlider(
                  options: CarouselOptions(
                    height: 410.h,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    exemplar2.data.capa,
                    exemplar2.data.contracapa,
                    exemplar2.data.corteDianteiro,
                    exemplar2.data.corteInferior,
                    exemplar2.data.corteSuperior,
                    exemplar2.data.lombada
                  ].map((i) {
                    // Itens
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0.r),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              i,
                            ),
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.r))),
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class InfoLivro extends StatelessWidget {
  var exemplar;
  InfoLivro({this.exemplar});
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return StreamBuilder(
      stream: firestore.getExemplar(exemplar),
      builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
        if (exemplar2.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (exemplar2.hasData) {
          return StreamBuilder(
            stream: firestore.getObra(exemplar2.data.isbn),
            builder: (BuildContext context, AsyncSnapshot<Obra> obra) {
              if (obra.hasData) {
                return Container(
                  padding: EdgeInsets.only(
                    left: 25.r,
                    right: 25.r,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40.h,
                        child: Text(
                          obra.data.titulo,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 25.ssp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'ISBN: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            exemplar2.data.isbn,
                            style: TextStyle(
                              fontSize: 20.ssp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Autor: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                obra.data.autor,
                                style: TextStyle(
                                  fontSize: 20.ssp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Editora: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.editora,
                            style: TextStyle(
                              fontSize: 20.ssp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Edição: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.edicao,
                            style: TextStyle(
                              fontSize: 20.ssp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Ano de Publicação: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.dataPubli,
                            style: TextStyle(
                              fontSize: 20.ssp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Categoria: ',
                            style: TextStyle(
                                fontSize: 20.ssp, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            width: 280.w,
                            child: Text(
                              obra.data.categoria
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              style: TextStyle(
                                fontSize: 20.ssp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
  }
}

class Condicao extends StatelessWidget {
  var exemplar;
  Condicao({this.exemplar});

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return StreamBuilder(
      stream: firestore.getExemplar(exemplar),
      builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
        if (exemplar2.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (exemplar2.hasData) {
          return Container(
            padding: EdgeInsets.only(
              left: 25.r,
              right: 25.r,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Condição do Livro',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.ssp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.1),
                      child: Text(
                        'O livro está em excelente estado geral',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ),
                    Container(
                      //color: Colors.grey,
                      child: Slider(
                        activeColor: Colors.deepPurple[600],
                        value: double.parse(exemplar2.data.resp1),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: exemplar2.data.resp1,
                        onChanged: (double value) {},
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'O livro não possui nenhum sinal de uso',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: double.parse(exemplar2.data.resp2),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: exemplar2.data.resp2,
                      onChanged: (double value) {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'O livro não possui nenhuma rasura',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: double.parse(exemplar2.data.resp3),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: exemplar2.data.resp3,
                      onChanged: (double value) {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'O livro não possui nenhuma pagina rasgada ou faltando',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: double.parse(exemplar2.data.resp4),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: exemplar2.data.resp4,
                      onChanged: (double value) {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'O livro não possui marcas de desgate do tempo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.ssp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: double.parse(exemplar2.data.resp5),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: exemplar2.data.resp5,
                      onChanged: (double value) {},
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
