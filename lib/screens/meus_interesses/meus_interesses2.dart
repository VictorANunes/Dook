import 'package:dook/provider/user_provider.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeusInteresses2Screen extends StatefulWidget {
  List<String> livros2;
  MeusInteresses2Screen({this.livros2});
  @override
  MeusInteresses2 createState() => MeusInteresses2(livros2: livros2);
}

class MeusInteresses2 extends State {
  List<String> livros2;
  MeusInteresses2({this.livros2});

  @override
  FirestoreService firestore = FirestoreService();
  bool value = false;
  List<String> livros = [];
  int qtdLivros = 0;
  final livro = TextEditingController();

  void initState() {
    super.initState();
    livros = livros2;
    qtdLivros = livros2.length;
  }

  Widget build(BuildContext context) {
    void addLivro() {
      var livrotexto = livro.text;
      //print(livrotexto);
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
          top: 35.h,
          left: 25.h,
          right: 25.h,
        ),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/images/icons/voltar.png',
                    height: 25.h,
                    width: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                width: 90.w,
              ),
              Container(
                child: Text('Cadastro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 38.ssp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                width: 200.w,
              ),
              Container(
                width: 85.w,
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
              fontSize: 18.ssp,
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
                fontSize: 18.ssp,
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
              fontSize: 16.ssp,
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
                              width: 310.w,
                              child: Text(
                                '${item}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19.ssp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2.r),
                              child: IconButton(
                                  alignment: Alignment.centerRight,
                                  icon: Image.asset(
                                    'assets/images/icons/lixeira verm.png',
                                    height: 23.h,
                                    width: 23.w,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      livros.removeAt(index);
                                      qtdLivros = qtdLivros - 1;
                                      print(livros);
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
            height: 30.h,
          ),
          ElevatedButton(
            onPressed: () {
              print(livros);
              firestore.updateLivrosInt(livros);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuInferiorScreen()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[600],
              minimumSize: Size(88.h, 50.h),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            child: Text(
              'Salvar',
              style: TextStyle(
                fontSize: 18.ssp,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
