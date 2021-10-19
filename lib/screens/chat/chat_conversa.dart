import 'package:dash_chat/dash_chat.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/chat/maleta_doador.dart';
import 'package:dook/screens/chat/maleta_receptor.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatConversaScreen extends StatefulWidget {
  var email;
  var outroUsuario;
  var meuUsuario;
  var doador;
  var receptor;
  ChatConversaScreen(
      {this.email,
      this.outroUsuario,
      this.meuUsuario,
      this.doador,
      this.receptor});
  @override
  ChatConversa createState() => ChatConversa(
      email: email,
      outroUsuario: outroUsuario,
      meuUsuario: meuUsuario,
      doador: doador,
      receptor: receptor);
}

class ChatConversa extends State {
  var email;
  var outroUsuario;
  var meuUsuario;
  var doador;
  var receptor;

  ChatConversa(
      {this.email,
      this.outroUsuario,
      this.meuUsuario,
      this.doador,
      this.receptor});

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
          children: [
            ConversaCabecalho(email: email, doador: doador, receptor: receptor),
            ConversaCorpoState(
                email: email,
                outroUsuario: outroUsuario,
                meuUsuario: meuUsuario,
                doador: doador,
                receptor: receptor),
          ],
        ),
      ),
    );
  }
}

class ConversaCabecalho extends StatelessWidget {
  var email;
  var doador;
  var receptor;
  ConversaCabecalho({this.email, this.doador, this.receptor});
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
                  stream: firestore.getUsuario(email),
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
                child: IconButton(
                  icon: Image.asset('assets/images/icons/prochat.png',
                      height: 30.h, width: 30.w),
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    var meuEmail = firestore.getEmail();
                    //meuEmail = 'b@gmail.com';
                    if (meuEmail == doador) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaletaDoadorScreen(
                                  outroEmail: email,
                                  doador: doador,
                                  receptor: receptor)));
                    } else {
                      if (meuEmail == receptor) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaletaReceptorScreen(
                                    outroEmail: email,
                                    doador: doador,
                                    receptor: receptor)));
                      }
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ConversaCorpoState extends StatefulWidget {
  var email;
  var outroUsuario;
  var meuUsuario;
  var doador;
  var receptor;

  ConversaCorpoState(
      {this.email,
      this.outroUsuario,
      this.meuUsuario,
      this.doador,
      this.receptor});
  ConversaCorpo createState() => ConversaCorpo(
      email: email,
      outroUsuario: outroUsuario,
      meuUsuario: meuUsuario,
      doador: doador,
      receptor: receptor);
}

class ConversaCorpo extends State {
  var email;
  var outroUsuario;
  var meuUsuario;
  String doador;
  String receptor;

  ConversaCorpo(
      {this.email,
      this.outroUsuario,
      this.meuUsuario,
      this.doador,
      this.receptor});

  FirestoreService firestore = FirestoreService();
  List<ChatMessage> mensagens = <ChatMessage>[];

  ChatUser user;
  ChatUser outroUser;

  void initState() {
    //inicializador
    user = ChatUser(
      name: meuUsuario.data.nome,
      uid: meuUsuario.data.email,
      avatar: meuUsuario.data.url,
    );

    outroUser = ChatUser(
      name: outroUsuario.data.nome,
      uid: outroUsuario.data.email,
      avatar: outroUsuario.data.url,
    );

    super.initState();
  }

  void enviarMsg(ChatMessage mensagem) {
    //Ao enviar mensagem chama essa função
    firestore.salvarMensagem(mensagem, doador, receptor);
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.getChat(doador, receptor),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.exists) {
          mensagens = [];
          List<dynamic> listaMensagens =
              snapshot.data['mensagens'].values.toList();

          //print(listaMensagens[0]['createdAt']);
          if (listaMensagens.isEmpty == false) {
            listaMensagens
                .sort((a, b) => a['createdAt'].compareTo(b['createdAt']));
          }

          for (var i in listaMensagens) {
            mensagens.add(ChatMessage.fromJson(i));
          }
          return DashChat(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120.h,
            messages: mensagens,
            user: user,
            onSend: enviarMsg,
            sendOnEnter: true,
            alwaysShowSend: true,
            textInputAction: TextInputAction.send,
            shouldShowLoadEarlier: false,
            scrollToBottom: false,
            inputDecoration:
                InputDecoration.collapsed(hintText: "Escreva uma mensagem"),
            inputContainerStyle: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 0.0),
              color: Colors.white,
            ),
            inputTextStyle: TextStyle(fontSize: 17.0),
            dateFormat: DateFormat('dd/MM/yyyy'),
            timeFormat: DateFormat('HH:mm'),
            showUserAvatar: true,
            showAvatarForEveryMessage: true,
            messageContainerPadding: EdgeInsets.only(left: 5.r, right: 5.r),
            messageDecorationBuilder: (ChatMessage msg, bool isUser) {
              return BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isUser ? Colors.deepPurple[600] : Colors.grey[200],
              );
            },
            inputCursorColor: Colors.deepPurple[600],
            onLoadEarlier: () {},
          );
        } else {
          return Text('');
        }
      },
    );
  }
}
