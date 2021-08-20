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
  @override
  bool value = false;
  List<Widget> dynamicList = [];
  List<String> livros = [];
  int qtdLivros = 0;
  final livro = TextEditingController();
  Widget build(BuildContext context) {
    void addLivro() {
      var livrotexto = livro.text;
      if (dynamicList.length >= 5) {
        return;
      } else {
        setState(() {
          qtdLivros = qtdLivros + 1;
          livros.add(livro.text);
        });
      }
      dynamicList.add(Container(
        child: Row(children: <Widget>[
          Container(
            width: 330,
            child: Text(
              '${livrotexto}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 19,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(Icons.clear_rounded),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    dynamicList.removeAt(qtdLivros - 1);
                    qtdLivros = qtdLivros - 1;
                  });
                }),
          ),
        ]),
      ));
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 40,
          left: 25,
          right: 25,
        ),
        child: ListView(children: <Widget>[
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Ação',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Aventura',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Romance',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Terror',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Drama',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.deepPurple[600],
                    value: this.value,
                    onChanged: (bool value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Acadêmico',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Livros de Interesse',
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
          TextFormField(
            controller: livro,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${qtdLivros}/5',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.right,
          ),
          Container(
            height: 265,
            child: Column(children: [
              //Parte que percorre a lista e cria Widgets Dinamicamente
              (dynamicList != null)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: dynamicList.length,
                      itemBuilder: (_, index) => dynamicList[index],
                    )
                  : Text(""),
            ]),
          ),
          SizedBox(
            height: 3,
          ),
          ElevatedButton(
            onPressed: () {
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
        ]),
      ),
    );
  }
}
