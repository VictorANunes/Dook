import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/interesse.dart';
import 'package:dook/screens/acervo.dart';
import 'package:dook/screens/chat.dart';
import 'package:dook/screens/menu.dart';

class MenuInferiorScreen extends StatefulWidget {
  @override
  MenuInferior createState() => MenuInferior();
}

class MenuInferior extends State {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    InteresseScreen(),
    AcervoScreen(),
    ChatScreen(),
  ];

  void mudarTela(int index) {
    setState(() {
      _indiceAtual = index;
      if (_indiceAtual == 3) {
        _indiceAtual = 0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _telas[_indiceAtual],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _indiceAtual,
            onTap: mudarTela,
            type: BottomNavigationBarType.fixed,
            iconSize: 40,
            selectedItemColor: Colors.deepPurple[600],
            unselectedItemColor: Colors.black.withOpacity(.90),
            selectedFontSize: 15,
            unselectedFontSize: 15,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 5,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories),
                //import_contacts_sharp
                label: 'Acervo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_rounded),
                //forum_outlined chat_bubble_outline_rounded
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded),
                label: 'Menu',
              ),
            ],
          ),
        ));
  }
}
