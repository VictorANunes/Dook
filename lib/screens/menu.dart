import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  @override
  Menu createState() => Menu();
}

class Menu extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Menu Screen'),
    );
  }
}
