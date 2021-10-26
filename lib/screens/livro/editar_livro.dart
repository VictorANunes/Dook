import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/screens/livro/editar_fotos.dart';
import 'package:dook/screens/livro/pagina_meu_livro.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EditarLivroScreen extends StatefulWidget {
  var exemplar;
  var condicao;
  EditarLivroScreen({this.exemplar, this.condicao});
  @override
  EditarLivro createState() =>
      EditarLivro(exemplar: exemplar, condicao: condicao);
}

final TextEditingController _controladorTitulo = TextEditingController();
final TextEditingController _controladorISBN = TextEditingController();
final TextEditingController _controladorAutor = TextEditingController();
final TextEditingController _controladorEdicao = TextEditingController();
final TextEditingController _controladorEditora = TextEditingController();
final TextEditingController _controladorDtPublicacao = TextEditingController();
final TextEditingController _controladorCategoria = TextEditingController();

double _currentSliderValue1 = 1;
double _currentSliderValue2 = 1;
double _currentSliderValue3 = 1;
double _currentSliderValue4 = 1;
double _currentSliderValue5 = 1;

class EditarLivro extends State {
  var exemplar;
  var condicao;
  EditarLivro({this.exemplar, this.condicao});
  void telaEditarFotos() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                EditarFotosScreen(exemplar: exemplar)));
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Superior(exemplar: exemplar),
              SizedBox(
                height: 35.h,
              ),
              Carrossel(exemplar: exemplar),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                onPressed: () {
                  telaEditarFotos();
                },
                child: Text(
                  'Editar Fotos',
                  style: TextStyle(
                    color: Colors.deepPurple[600],
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              InfoLivro(exemplar: exemplar),
              SizedBox(
                height: 30.h,
              ),
              Condicao(exemplar: exemplar, condicao: condicao),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[600],
                  minimumSize: Size(382.h, 55.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: () {
                  List<double> respostas = new List(5);
                  respostas[0] = _currentSliderValue1;
                  respostas[1] = _currentSliderValue2;
                  respostas[2] = _currentSliderValue3;
                  respostas[3] = _currentSliderValue4;
                  respostas[4] = _currentSliderValue5;

                  firestore.updateRespostas(exemplar, respostas);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MenuInferiorScreen()));
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18.sp),
                ),
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
            'Editar Livro',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              //ao apagar, verificar se tem chat aberto e fecha-lo tbm
              firestore.deleteChatWithExemplar(exemplar);
              firestore.deleteExemplar(exemplar);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MenuInferiorScreen(),
                ),
              );
            },
            icon: Image.asset(
              'assets/images/icons/lixeira verm.png',
              height: 28.h,
              width: 28.w,
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
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
                            fontSize: 25.sp,
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
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            exemplar2.data.isbn,
                            style: TextStyle(
                              fontSize: 20.sp,
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
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                obra.data.autor,
                                style: TextStyle(
                                  fontSize: 20.sp,
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
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.editora,
                            style: TextStyle(
                              fontSize: 20.sp,
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
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.edicao,
                            style: TextStyle(
                              fontSize: 20.sp,
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
                            'Data de Publicação: ',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.dataPubli,
                            style: TextStyle(
                              fontSize: 20.sp,
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
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            obra.data.categoria
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                            style: TextStyle(
                              fontSize: 20.sp,
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

class Condicao extends StatefulWidget {
  var exemplar;
  var condicao;
  Condicao({this.exemplar, this.condicao});
  @override
  CondicaoState createState() =>
      CondicaoState(exemplar: exemplar, condicao: condicao);
}

class CondicaoState extends State {
  var exemplar;
  var condicao;
  CondicaoState({this.exemplar, this.condicao});

  @override
  void initState() {
    _currentSliderValue1 = double.parse(condicao[0]);
    _currentSliderValue2 = double.parse(condicao[1]);
    _currentSliderValue3 = double.parse(condicao[2]);
    _currentSliderValue4 = double.parse(condicao[3]);
    _currentSliderValue5 = double.parse(condicao[4]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();

    return StreamBuilder(
      stream: firestore.getExemplar(exemplar),
      builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
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
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'O livro está em excelente estado geral',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: _currentSliderValue1,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue1.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue1 = value;
                        });
                      },
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
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: _currentSliderValue2,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue2.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue2 = value;
                        });
                      },
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
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: _currentSliderValue3,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue3.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue3 = value;
                        });
                      },
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
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: _currentSliderValue4,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue4.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue4 = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'O livro tem menos de um ano desde que foi adquirido.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.deepPurple[600],
                      value: _currentSliderValue5,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentSliderValue5.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue5 = value;
                        });
                      },
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
