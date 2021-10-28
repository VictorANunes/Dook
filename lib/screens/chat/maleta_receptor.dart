import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/provider/chat_provider.dart';
import 'package:dook/screens/chat/avaliacao.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:dook/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaletaReceptorScreen extends StatefulWidget {
  var outroEmail;
  var doador;
  var receptor;
  MaletaReceptorScreen({this.outroEmail, this.doador, this.receptor});
  MaletaReceptor createState() => MaletaReceptor(
      outroEmail: outroEmail, doador: doador, receptor: receptor);
}

class MaletaReceptor extends State {
  var outroEmail;
  var doador;
  var receptor;
  MaletaReceptor({this.outroEmail, this.doador, this.receptor});
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
              top: 30.r,
              left: 25.r,
              right: 25.r,
            ),
            child: ListView(children: [
              MaletaReceptorCabecalho(outroEmail: outroEmail),
              SizedBox(
                height: 35.h,
              ),
              MaletaReceptorCorpo(doador: doador, receptor: receptor)
            ])));
  }
}

class MaletaReceptorCabecalho extends StatelessWidget {
  var outroEmail;
  MaletaReceptorCabecalho({this.outroEmail});
  FirestoreService firestore = FirestoreService();
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80.w,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/icons/voltar.png',
                    height: 25.h,
                    width: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              StreamBuilder(
                  stream: firestore.getUsuario(outroEmail),
                  builder:
                      (BuildContext context, AsyncSnapshot<Users> usuario) {
                    if (usuario.hasData) {
                      String nome3 = '';
                      String nome = usuario.data.nome;
                      List<String> nome2 = nome.split(" ");
                      if (nome2[0] != nome2[nome2.length - 1]) {
                        nome3 = nome2[0] + " " + nome2[nome2.length - 1];
                      } else {
                        nome3 = nome2[0];
                      }
                      return Container(
                        alignment: Alignment.center,
                        width: 220.w,
                        child: Text(
                          nome3,
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.w600),
                        ),
                      );
                    } else {
                      return Text(' ');
                    }
                  }),
              Container(
                width: 80.w,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MaletaReceptorCorpo extends StatelessWidget {
  var doador;
  var receptor;

  MaletaReceptorCorpo({this.doador, this.receptor});

  FirestoreService firestore = FirestoreService();

  var idExemplar;
  var listaEspera;

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        StreamBuilder(
            stream: firestore.getChat(doador, receptor),
            builder: (BuildContext context, AsyncSnapshot chat) {
              if (chat.hasData && chat.data.exists) {
                idExemplar = chat.data['exemplar'];
                return StreamBuilder(
                    stream: firestore.getExemplar(idExemplar),
                    builder: (BuildContext context,
                        AsyncSnapshot<Exemplar> exemplar) {
                      if (exemplar.hasData) {
                        if (exemplar.data.status == 'enviado') {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple[600],
                                  minimumSize: Size(382.h, 55.h),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                child: Text(
                                  'Confirmar Recebimento',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                onPressed: () {
                                  NotificationService ns =
                                      NotificationService();
                                  ns.sendNotification(
                                      'O Livro foi Recebido',
                                      'O usuário confirmou o recebimento do Livro!',
                                      doador,
                                      'Livro Recebido');
                                  firestore.updateStatusExemplar(
                                      idExemplar, 'fechado');

                                  listaEspera = exemplar.data.listaEspera;
                                  listaEspera.removeAt(0);

                                  firestore.updateListaEspera(
                                      idExemplar, listaEspera);

                                  firestore.removeChat(doador, receptor);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AvaliacaoScreen(doador: doador)));
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple[600],
                                  minimumSize: Size(382.h, 55.h),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                child: Text(
                                  'Encerrar Chat',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                onPressed: () {
                                  //Implementar função para abrir chat com o próximo da lista
                                  NotificationService ns =
                                      NotificationService();
                                  listaEspera = exemplar.data.listaEspera;
                                  var tamanho = listaEspera.length;

                                  if (tamanho > 1) {
                                    ChatProvider chat = new ChatProvider();
                                    chat.changeData(
                                        DateTime.now().millisecondsSinceEpoch);
                                    chat.changeDoador(doador);
                                    chat.changeReceptor(listaEspera[1]);
                                    chat.changeExemplar(idExemplar);
                                    chat.saveChat();
                                    ns.sendNotification(
                                        'Chegou sua Vez',
                                        'O Chat já está liberado para conversar com o doador!',
                                        listaEspera[1],
                                        'Chat Liberado');

                                    ns.sendNotification(
                                        'Chat Liberado',
                                        'O Chat com o próximo da lista de espera já está disponível!',
                                        doador,
                                        'Chat Liberado');
                                    //mandar notificacao para listaEspera[1]
                                  }

                                  listaEspera.removeAt(0);

                                  firestore.updateListaEspera(
                                      idExemplar, listaEspera);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuInferiorScreen()));

                                  firestore.removeChat(doador, receptor);
                                },
                              ),
                            ],
                          );
                        } else {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple[600],
                              minimumSize: Size(382.h, 55.h),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            child: Text(
                              'Encerrar Chat',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              // encerrar chat
                              listaEspera = exemplar.data.listaEspera;
                              listaEspera.removeAt(0);

                              firestore.updateListaEspera(
                                  idExemplar, listaEspera);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuInferiorScreen()));

                              firestore.removeChat(doador, receptor);
                            },
                          );
                        }
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            }),
      ],
    );
  }
}
