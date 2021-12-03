import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/chat/chat_conversa.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  @override
  Chat createState() => Chat();
}

class Chat extends State {
  @override
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
        child: ListView(
          children: <Widget>[
            ChatCabecalho(),
            SizedBox(
              height: 25.h,
            ),
            ChatConversas(),
          ],
        ),
      ),
    );
  }
}

class ChatCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(''),
              ),
              Container(
                child: Text(
                  'Chat',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 38.ssp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatConversas extends StatelessWidget {
  FirestoreService firestore = FirestoreService();

  Widget build(BuildContext context) {
    List<DocumentSnapshot> listaConversas = <DocumentSnapshot>[];
    var email = firestore.getEmail();

    return StreamBuilder(
        //Pega a query 1 que resgata as conversas que o usuario esta como doador
        stream: firestore.listarConversas(),
        builder: (BuildContext context, AsyncSnapshot snapshot1) {
          if (snapshot1.hasData) {
            return StreamBuilder(
                //Pega a query 2 que resgata as conversas que o usuario esta como receptor
                stream: firestore.listarConversas2(),
                builder: (BuildContext context, AsyncSnapshot snapshot2) {
                  if (snapshot2.hasData) {
                    listaConversas = snapshot1.data.docs +
                        snapshot2.data
                            .docs; //Juntar os dois resultados da query e colocar em uma lista

                    if (listaConversas.isEmpty == false) {
                      listaConversas.sort((a, b) => b['data'].compareTo(a[
                          'data'])); //Ordenar a lista pela Data que vai atualizar de acordo com a ultima mensagem enviada
                      return ListView.builder(
                          //Listar as conversas
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listaConversas.length,
                          itemBuilder: (BuildContext context, int index) {
                            var email2;
                            if (email == listaConversas[index]['doador']) {
                              //se meu email for igual ao daodor entao pego o do receptor
                              email2 = listaConversas[index]['receptor'];
                            } else {
                              if (email == listaConversas[index]['receptor']) {
                                //se meu email for igual ao receptor entao pego o do doador
                                email2 = listaConversas[index]['doador'];
                              }
                            }
                            return StreamBuilder(
                                //Stream que pega o meu Usuario para enviar como parametro
                                stream: firestore.getDadosUsuario(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Users> meuUsuario) {
                                  if (meuUsuario.hasData) {
                                    return StreamBuilder(
                                      //Pega os dados do outro usuário através do email2
                                      stream: firestore.getUsuario(email2),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Users> usuario) {
                                        if (usuario.hasData) {
                                          //Pegar primeiro e ultimo nome apenas
                                          String doador =
                                              listaConversas[index]['doador'];
                                          String receptor =
                                              listaConversas[index]['receptor'];

                                          String nome3 = '';
                                          String nome = usuario.data.nome;
                                          List<String> nome2 = nome.split(" ");
                                          if (nome2[0] !=
                                              nome2[nome2.length - 1]) {
                                            nome3 = nome2[0] +
                                                " " +
                                                nome2[nome2.length - 1];
                                          } else {
                                            nome3 = nome2[0];
                                          }
                                          //Gesture Detector para colocar a ação de onTap na Row
                                          return ListView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatConversaScreen(
                                                                email: email2,
                                                                outroUsuario:
                                                                    usuario,
                                                                meuUsuario:
                                                                    meuUsuario,
                                                                doador: doador,
                                                                receptor:
                                                                    receptor)), //enviar parametros
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      //Mostrar foto de perfil redonda
                                                      width: 120.w,
                                                      height: 120.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .deepPurple[300],
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(2.r),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                      usuario
                                                                          .data
                                                                          .url),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          //Exibe o nome da pessoa
                                                          width: 240.w,
                                                          child: Text(
                                                            nome3,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    25.ssp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        StreamBuilder(
                                                            //Pega os dados do exemplar para colocar o nome do livro
                                                            stream: firestore
                                                                .getExemplar(
                                                                    listaConversas[
                                                                            index]
                                                                        [
                                                                        'exemplar']),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        Exemplar>
                                                                    exemplar) {
                                                              if (exemplar
                                                                  .hasData) {
                                                                return StreamBuilder(
                                                                    //Através do exemplar pegar o ISBN e puxar a Obra cadastrada
                                                                    stream: firestore.getObra(
                                                                        exemplar
                                                                            .data
                                                                            .isbn),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<Obra>
                                                                            obra) {
                                                                      if (obra
                                                                          .hasData) {
                                                                        return Container(
                                                                          width:
                                                                              240.w,
                                                                          child:
                                                                              Text(
                                                                            obra.data.titulo,
                                                                            style:
                                                                                TextStyle(fontSize: 16.ssp),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Text(
                                                                            '');
                                                                      }
                                                                    });
                                                              } else {
                                                                return Text('');
                                                              }
                                                            }),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              )
                                            ],
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  Colors.deepPurple[600],
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    return Text('');
                                  }
                                });
                          });
                    } else {
                      return Center(
                        child: Text(
                          'Você ainda não tem nenhuma negociação em andamento!',
                          style: TextStyle(
                              fontSize: 19.ssp, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  } else {
                    return Center();
                  }
                });
          } else {
            return Center();
          }
        });
  }
}
