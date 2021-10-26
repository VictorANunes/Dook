import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/provider/chat_provider.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/screens/perfil/perfil.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LivroScreen extends StatefulWidget {
  var exemplar;
  LivroScreen({this.exemplar});

  @override
  Livro createState() => Livro(exemplar: exemplar);
}

class Livro extends State {
  var exemplar;
  Livro({this.exemplar});

  void showAlertDialog1(BuildContext context) {
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      contentPadding: EdgeInsets.only(top: 15.r),
      content: Container(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/icons/aceitar.png',
                  color: Colors.green,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Parabéns',
              style: TextStyle(fontSize: 27.sp),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, right: 20.r),
              child: Text(
                'Você é o primeiro interessado neste livro e o chat com o doador já está disponível.',
                style: TextStyle(fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              child: Container(
                width: 300.w,
                padding: EdgeInsets.only(top: 6.r, bottom: 6.r),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MenuInferiorScreen()),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void showAlertDialog2(BuildContext context, int tamanho) {
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      contentPadding: EdgeInsets.only(top: 15.r),
      content: Container(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/icons/aceitar.png',
                  color: Colors.green,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Parabéns',
              style: TextStyle(fontSize: 27.sp),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, right: 20.r),
              child: Text(
                'Você entrou na Lista de Espera deste livro, sua posição na fila é a $tamanhoº. Assim que chegar a sua vez você será notificado.',
                style: TextStyle(fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              child: Container(
                width: 300.w,
                padding: EdgeInsets.only(top: 6.r, bottom: 6.r),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MenuInferiorScreen()),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void showAlertDialog3(BuildContext context) {
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      contentPadding: EdgeInsets.only(top: 15.r),
      content: Container(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/icons/delete.png',
                  color: Colors.red,
                  height: 80.h,
                  width: 80.w,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Que Pena',
              style: TextStyle(fontSize: 27.sp),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, right: 20.r),
              child: Text(
                'Você se retirou da Lista de Espera deste Livro.',
                style: TextStyle(fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              child: Container(
                width: 300.w,
                padding: EdgeInsets.only(top: 6.r, bottom: 6.r),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MenuInferiorScreen()),
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Superior(),
          SizedBox(
            height: 35.h,
          ),
          Carrossel(exemplar: exemplar),
          SizedBox(
            height: 30.h,
          ),
          InfoLivro(exemplar: exemplar),
          SizedBox(
            height: 30.h,
          ),
          Condicao(
            exemplar: exemplar,
          ),
          SizedBox(
            height: 50.h,
          ),
          StreamBuilder(
            stream: firestore.getExemplar(exemplar),
            builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
              if (exemplar2.hasData) {
                if (!exemplar2.data.listaEspera
                    .contains(firestore.getEmail())) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: 25.r,
                      right: 25.r,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[600],
                        minimumSize: Size(382.h, 55.h),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () {
                        List<String> listaEspera = exemplar2.data.listaEspera;
                        var tamanho = 0;
                        if (listaEspera.isEmpty) {
                          //se for vazio mandar alerta dizendo que o chat foi aberto e abrir o chat
                          listaEspera.add(firestore.getEmail());
                          firestore.updateListaEspera(exemplar, listaEspera);

                          ChatProvider chat = new ChatProvider();
                          chat.changeData(
                              DateTime.now().millisecondsSinceEpoch);
                          chat.changeDoador(exemplar2.data.criador);
                          chat.changeReceptor(firestore.getEmail());
                          chat.changeExemplar(exemplar);
                          chat.saveChat();

                          showAlertDialog1(context);
                        } else {
                          //se não for vazio mandar alerta mandando posição da lista e adicionar ele na lista
                          tamanho = listaEspera.length + 1;
                          if (!listaEspera.contains(firestore.getEmail())) {
                            listaEspera.add(firestore.getEmail());
                            firestore.updateListaEspera(exemplar, listaEspera);
                            showAlertDialog2(context, tamanho);
                          }
                        }
                      },
                      child: Text(
                        'Tenho Interesse',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(
                      left: 25.r,
                      right: 25.r,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[600],
                        minimumSize: Size(382.h, 55.h),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () async {
                        List<String> listaEspera = exemplar2.data.listaEspera;

                        if (listaEspera[0] == firestore.getEmail()) {
                          firestore.removeChat(
                              exemplar2.data.criador, firestore.getEmail());
                          var tamanho = listaEspera.length;
                          if (tamanho > 1) {
                            ChatProvider chat = new ChatProvider();
                            chat.changeData(
                                DateTime.now().millisecondsSinceEpoch);
                            chat.changeDoador(exemplar2.data.criador);
                            chat.changeReceptor(listaEspera[1]);
                            chat.changeExemplar(exemplar);
                            chat.saveChat();
                            //mandar notificacao para listaEspera[1]
                          }
                        }

                        listaEspera.remove(firestore.getEmail());
                        firestore.updateListaEspera(exemplar, listaEspera);
                        showAlertDialog3(context);
                      },
                      child: Text(
                        'Cancelar Interesse',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  );
                }
              } else {
                return Container();
              }
            },
          ),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }
}

class Superior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 30.r,
            left: 25.r,
            right: 25.r,
          ),
          child: IconButton(
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
          width: 90.w,
        ),
        Container(
          padding: EdgeInsets.only(
            top: 30.r,
            left: 25.r,
            right: 25.r,
          ),
          child: Text(
            'Livro',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.sp,
            ),
          ),
        ),
        Container(
          width: 90.w,
        )
      ],
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
                            image: NetworkImage(i),
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
              if (obra.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurple[600],
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
              if (obra.hasData) {
                return StreamBuilder(
                  stream: firestore.getUsuario(exemplar2.data.criador),
                  builder:
                      (BuildContext context, AsyncSnapshot<Users> usuario) {
                    if (usuario.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.deepPurple[600],
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    }
                    if (usuario.hasData) {
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
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PerfilScreen(email: usuario.data.email),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    //Mostrar foto de perfil redonda
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[200],
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
                                            image:
                                                NetworkImage(usuario.data.url),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(usuario.data.nome,
                                      style: TextStyle(fontSize: 19.sp))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'ISBN: ',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
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
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 280.w,
                                  child: Text(
                                    obra.data.categoria
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    style: TextStyle(
                                      fontSize: 20.sp,
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
                    fontSize: 25.sp,
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
                        style: TextStyle(fontSize: 18.sp),
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
                        style: TextStyle(fontSize: 18.sp),
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
                        style: TextStyle(fontSize: 18.sp),
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
                        style: TextStyle(fontSize: 18.sp),
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
                        'O livro tem menos de um ano desde que foi adquirido.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.sp),
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
