import 'package:dook/screens/chat/chat_conversa.dart';
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
            children: <Widget>[
              Container(
                width: 155.w,
                child: Text(''),
              ),
              Container(
                width: 200.w,
                child: Text(
                  'Chat',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 38.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 25.w,
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
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatConversaScreen()),
            );
          },
          child: Row(
            children: [
              Container(
                //Mostrar foto de perfil redonda
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
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
                        image: NetworkImage(
                            'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 240.w,
                    child: Text(
                      'Rayara Santos',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 240.w,
                    child: Text(
                      'Percy Jackson e o mar de Monstros',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Container(
              //Mostrar foto de perfil redonda
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.deepPurple[300],
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
                      image: NetworkImage(
                          'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 240.w,
                  child: Text(
                    'Victor Alves',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: 240.w,
                  child: Text(
                    'Harry Potter e o Prisioneiro de Azkaban',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
