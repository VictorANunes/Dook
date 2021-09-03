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
      body: Text('Chat Screen'),
    );
  }
}
