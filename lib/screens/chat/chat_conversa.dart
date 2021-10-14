import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatConversaScreen extends StatefulWidget {
  @override
  ChatConversa createState() => ChatConversa();
}

class ChatConversa extends State {
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
            ConversaCabecalho(),
            ConversaCorpoState(),
          ],
        ),
      ),
    );
  }
}

class ConversaCabecalho extends StatelessWidget {
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
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 220.w,
                child: Text(
                  'Rayara Santos',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 80.w,
                child: IconButton(
                  icon: Icon(Icons.card_travel),
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.pop(context);
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
  ConversaCorpo createState() => ConversaCorpo();
}

class ConversaCorpo extends State {
  List<ChatMessage> messages = <ChatMessage>[];

  void enviarMsg(ChatMessage message) {
    //Ao enviar mensagem chama essa função
    //print(message.toJson());
    messages.add(message);
    /*FirebaseFirestore.instance
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(message.toJson());*/
  }

  final ChatUser usuario = ChatUser(
    //exemplo de usuário
    name: "Luis",
    uid: "123456789",
    avatar:
        "https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg",
  );

  Widget build(BuildContext context) {
    return DashChat(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 120.h,
      messages: messages,
      user: usuario,
      onSend: enviarMsg,
      sendOnEnter: true,
      alwaysShowSend: true,
      textInputAction: TextInputAction.send,
      inputDecoration:
          InputDecoration.collapsed(hintText: "Escreva sua mensagem..."),
      inputContainerStyle: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 0.0),
        color: Colors.white,
      ),
      inputTextStyle: TextStyle(fontSize: 16.0),
      dateFormat: DateFormat('dd/MM/yyyy'),
      timeFormat: DateFormat('HH:mm'),
      showUserAvatar: false,
      messageContainerPadding: EdgeInsets.only(left: 5.r, right: 5.r),
      messageDecorationBuilder: (ChatMessage msg, bool isUser) {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isUser ? Colors.deepPurple[600] : Colors.grey[800],
        );
      },
      inputCursorColor: Colors.deepPurple[600],
      leading: <Widget>[
        IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.deepPurple[600],
            ),
            onPressed: () {})
      ],
      scrollToBottomStyle:
          ScrollToBottomStyle(backgroundColor: Colors.deepPurple[300]),
    );
  }
}
