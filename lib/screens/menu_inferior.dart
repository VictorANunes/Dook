import 'package:flutter/material.dart';
import 'package:dook/screens/interesse.dart';
import 'package:dook/screens/acervo.dart';
import 'package:dook/screens/chat/chat.dart';
import 'package:dook/screens/menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                icon: (_indiceAtual == 0)
                    ? Image.asset(
                        'assets/images/icons/homeroxo.png',
                        height: 32.h,
                        width: 32.w,
                      )
                    : Image.asset(
                        'assets/images/icons/home.png',
                        height: 32.h,
                        width: 32.w,
                      ),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: (_indiceAtual == 1)
                    ? Image.asset(
                        'assets/images/icons/acervoroxo.png',
                        height: 32.h,
                        width: 32.w,
                      )
                    : Image.asset(
                        'assets/images/icons/acervo.png',
                        height: 32.h,
                        width: 32.w,
                      ),
                //import_contacts_sharp
                label: 'Acervo',
              ),
              BottomNavigationBarItem(
                icon: (_indiceAtual == 2)
                    ? Image.asset(
                        'assets/images/icons/chatroxo.png',
                        height: 32.h,
                        width: 32.w,
                      )
                    : Image.asset(
                        'assets/images/icons/chat.png',
                        height: 32.h,
                        width: 32.w,
                      ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/icons/menu.png',
                  height: 32.h,
                  width: 32.w,
                ),
                label: 'Menu',
              ),
            ],
          ),
        ));
  }
}
