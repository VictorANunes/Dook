import 'package:dook/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dook/screens/cadastro/cadastro_5.dart';

class CadastroScreen4 extends StatefulWidget {
  UserProvider user;
  CadastroScreen4({this.user});
  @override
  Cadastro4 createState() => Cadastro4(user: user);
}

class Cadastro4 extends State {
  UserProvider user;
  Cadastro4({this.user});
  int qtdGen = 0;
  String valuee;
  String dropDownValue;
  List<String> generosInt = [];
  List<String> generos = [
    'Ação',
    'Aventura',
    'Romance',
    'Terror',
    'Infantil',
    'Educação'
  ];
  @override
  Widget build(BuildContext context) {
    void addGenero() {
      if (generosInt.length >= 5) {
        return;
      } else {
        setState(() {
          var cont = 0;
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
          top: 40,
          left: 25,
          right: 25,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Row(children: <Widget>[
                Container(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 30,
                    ),
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  width: 90,
                ),
                Container(
                  child: Text('Cadastro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 38,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  width: 200,
                ),
                Container(
                  width: 90,
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Gêneros de Interesse',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
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
              height: 5,
            ),
            Text(
              '${qtdGen}/5',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 400,
              child: Column(children: [
                //Parte que percorre a lista e cria Widgets Dinamicamente
                (generosInt != null)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: generosInt.length,
                        itemBuilder: (context, index) {
                          final item = generosInt[index];
                          return /*Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              setState(() {
                                generosInt.removeAt(index);
                                qtdGen = qtdGen - 1;
                              });
                              // Exibe o snackbar
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("$item foi removido"),
                                ),
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment(-0.9, 0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                '${item}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );*/
                              Container(
                            child: Row(children: <Widget>[
                              Container(
                                width: 330,
                                child: Text(
                                  '${item}',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                child: IconButton(
                                    alignment: Alignment.centerRight,
                                    icon: Icon(Icons.delete),
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
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                String gen;
                for (var i = 0; i < generosInt.length; i++) {
                  if (i == 0) {
                    gen = generosInt[i] + ",";
                  } else {
                    gen = gen + generosInt[i] + ",";
                  }
                  print(gen);
                }
                user.changeGenerosInt(generosInt);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CadastroScreen5(user: user)));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[600],
                minimumSize: Size(88, 50),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                'Próximo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Escolher Depois',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(47, 128, 237, 1.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CadastroScreen5(user: user)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
