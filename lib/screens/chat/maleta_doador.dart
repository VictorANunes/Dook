import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaletaDoadorScreen extends StatefulWidget {
  var outroEmail;
  var doador;
  var receptor;
  MaletaDoadorScreen({this.outroEmail, this.doador, this.receptor});
  MaletaDoador createState() =>
      MaletaDoador(outroEmail: outroEmail, doador: doador, receptor: receptor);
}

class MaletaDoador extends State {
  var outroEmail;
  var doador;
  var receptor;
  MaletaDoador({this.outroEmail, this.doador, this.receptor});
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
              MaletaDoadorCabecalho(outroEmail: outroEmail),
              SizedBox(
                height: 35.h,
              ),
              MaletaDoadorCorpo(doador: doador, receptor: receptor)
            ])));
  }
}

class MaletaDoadorCabecalho extends StatelessWidget {
  var outroEmail;
  MaletaDoadorCabecalho({this.outroEmail});
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

class MaletaDoadorCorpo extends StatelessWidget {
  var doador;
  var receptor;
  MaletaDoadorCorpo({this.doador, this.receptor});

  FirestoreService firestore = FirestoreService();

  var idExemplar;
  List<String> listaEspera;

  Widget build(BuildContext context) {
    try {} catch (e) {}
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
                        if (exemplar.data.status == 'aberto') {
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
                                  'Confirmar Envio',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                onPressed: () {
                                  firestore.updateStatusExemplar(
                                      idExemplar, 'enviado');
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
                              'Cancelar Envio',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              firestore.updateStatusExemplar(
                                  idExemplar, 'aberto');
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
