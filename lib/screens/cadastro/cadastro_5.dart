import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/cadastro/cadastro_6.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CadastroScreen5 extends StatefulWidget {
  UserProvider user;
  CadastroScreen5({this.user});
  @override
  Cadastro5 createState() => Cadastro5(user: user);
}

class Cadastro5 extends State {
  UserProvider user;
  Cadastro5({this.user});
  @override
  bool value = false;
  List<String> livros = [];
  int qtdLivros = 0;
  final livro = TextEditingController();
  Widget build(BuildContext context) {
    void addLivro() {
      var livrotexto = livro.text;
      if (livros.length >= 5) {
        return;
      } else {
        setState(() {
          var cont = 0;
          for (var i = 0; i < livros.length; i++) {
            if (livrotexto == livros[i]) {
              cont = cont + 1;
            }
          }
          if (cont == 0) {
            qtdLivros = qtdLivros + 1;
            livros.add(livrotexto);
          }
        });
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40.h,
          left: 25.h,
          right: 25.h,
        ),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(children: <Widget>[
              Container(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                width: 90.w,
              ),
              Container(
                child: Text('Cadastro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 38.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                width: 200.w,
              ),
              Container(
                width: 90.w,
              ),
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Livros de Interesse',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            controller: livro,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Digite...",
              suffixIcon: IconButton(
                icon: Icon(Icons.add_outlined),
                onPressed: () {
                  addLivro();
                },
              ),
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            '${qtdLivros}/5',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.right,
          ),
          Container(
            height: 450.h,
            child: Column(children: [
              //Parte que percorre a lista e cria Widgets Dinamicamente
              (livros != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: livros.length,
                      itemBuilder: (context, index) {
                        final item = livros[index];
                        return Container(
                          child: Row(children: <Widget>[
                            Container(
                              width: 330.w,
                              child: Text(
                                '${item}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2.r),
                              child: IconButton(
                                  alignment: Alignment.centerRight,
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      livros.removeAt(index);
                                      qtdLivros = qtdLivros - 1;
                                    });
                                  }),
                            ),
                          ]),
                        );
                      },
                    )
                  : Text(""),
            ]),
          ),
          SizedBox(
            height: 3.h,
          ),
          ElevatedButton(
            onPressed: () {
              user.changeLivrosInt(livros);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CadastroScreen6(user: user)));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[600],
              minimumSize: Size(88.h, 50.h),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            child: Text(
              'Próximo',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            child: Text(
              'Escolher Depois',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                color: Color.fromRGBO(47, 128, 237, 1.0),
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CadastroScreen6(user: user)));
            },
          ),
        ]),
      ),
    );
  }
}
