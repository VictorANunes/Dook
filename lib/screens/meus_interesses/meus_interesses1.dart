import 'package:dook/screens/meus_interesses/meus_interesses2.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeusInteresses1Screen extends StatefulWidget {
  List<String> generos2;
  List<String> livros2;
  MeusInteresses1Screen({this.generos2, this.livros2});
  @override
  MeusInteresses createState() =>
      MeusInteresses(generos2: generos2, livros2: livros2);
}

class MeusInteresses extends State {
  List<String> generos2;
  List<String> livros2;
  MeusInteresses({this.generos2, this.livros2});

  FirestoreService firestore = FirestoreService();
  int qtdGen = 0;
  String valuee;
  String dropDownValue;
  var cont = 0;
  List<String> generosInt = [];
  List<String> generos = [
    'Ação',
    'Aventura',
    'Terror',
    'Infantil',
    'Educação',
    'Material Acadêmico',
    'Infanto-Juvenil',
    'Romance',
    'Romance Biográfico',
    'Romance Epistolar',
    'Romance Histórico',
    'Romance Psicólogo',
    'Novela',
    'Conto',
    'Crônica',
    'Ensaio',
    'Poesia',
    'Carta',
    'Biografia',
    'Memórias',
    'Drama',
    'Graphic Novel',
    'História em Quadrinhos (HQ)',
    'Lad-Lit',
    'Literatura fantástica',
    'Literatura Infantil',
    'Literatura Infanto-juvenil',
    'New Adult',
    'Realismo Mágico',
    'Terror',
    'Thriller ou suspense',
    'Conspiração',
    'Época',
    'Jurídico',
    'Médico',
    'Policial',
    'Psicológico',
    'Romântico',
    'Suspense',
    'Ficção'
  ];

  void initState() {
    super.initState();
    generosInt = generos2;
    qtdGen = generos2.length;
  }

  @override
  Widget build(BuildContext context) {
    void addGenero() {
      if (generosInt.length >= 5) {
        return;
      } else {
        setState(() {
          cont = 0;
          for (var i = 0; i < generosInt.length; i++) {
            if (dropDownValue == generosInt[i]) {
              cont = cont + 1;
            }
          }
          if (cont == 0) {
            qtdGen = qtdGen + 1;
            generosInt.add(dropDownValue);
          }
        });
      }
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 35.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
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
                  width: 90.w,
                ),
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Gêneros de Interesse',
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
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 20.r,
                  bottom: 20.r,
                  left: 15.r,
                  right: 15.r,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Selecione os gêneros",
              ),
              value: dropDownValue,
              onChanged: (String Value) {
                setState(() {
                  dropDownValue = Value;
                  addGenero();
                });
              },
              items: generos
                  .map((generos) =>
                      DropdownMenuItem(value: generos, child: Text("$generos")))
                  .toList(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              '${qtdGen}/5',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.ssp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 400.h,
              child: Column(children: [
                //Parte que percorre a lista e cria Widgets Dinamicamente

                (generosInt != null)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: generosInt.length,
                        itemBuilder: (context, index) {
                          final item = generosInt[index];
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
                                        generosInt.removeAt(index);
                                        qtdGen = qtdGen - 1;
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
              height: 65.h,
            ),
            ElevatedButton(
              onPressed: () {
                firestore.updateGenInt(generosInt);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MeusInteresses2Screen(livros2: livros2)));
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
                  fontSize: 18.ssp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
