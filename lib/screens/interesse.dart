import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/pesquisa.dart';

class InteresseScreen extends StatefulWidget {
  @override
  Interesse createState() => Interesse();
}

class Interesse extends State {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = new FirestoreService();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 18.r,
          left: 19.r,
          right: 20.r,
        ),
        child: ListView(
          children: <Widget>[
            IntCabecalho(),
            SizedBox(
              height: 20.h,
            ),
            IntGenerosInteresse(),
            IntListaDesejos(),
            IntMeusAnuncios(),
            /*StreamBuilder<DocumentSnapshot>(
                stream: firestore.pegarDados(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Center(child: new CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return Text(snapshot.data['nome']);
                  } else {
                    return Text('vazio');
                  }
                }),*/
          ],
        ),
      ),
    );
  }
}

class IntCabecalho extends StatelessWidget {
  @override
  final pesquisa = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 340.w,
            child: TextFormField(
              cursorColor: Colors.deepPurple[600],
              controller: pesquisa,
              decoration: InputDecoration(
                hasFloatingPlaceholder: false,
                contentPadding: EdgeInsets.only(
                  top: 15.r,
                  bottom: 15.r,
                  left: 15.r,
                  right: 15.r,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.deepPurple[600])),
                labelText: "Pesquisar",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                suffixIcon: IconButton(
                    //ou prefix
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.deepPurple[600],
                    ),
                    onPressed: () {
                      if (pesquisa.text != "") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PesquisaScreen(
                                        pesquisa:
                                            pesquisa.text.toLowerCase())));
                      }
                    }),
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: 40.w,
            padding: EdgeInsets.only(bottom: 10.r),
            child: IconButton(
              icon: Icon(
                //Icons.notifications_none,
                //color: Colors.black45,
                Icons.notifications,
                color: Colors.deepPurple[600],
                size: 40,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class IntGenerosInteresse extends StatelessWidget {
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 245.h,
      child: Column(
        children: <Widget>[
          Text(
            'Livros que Podem te Interessar',
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 195.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://livrariascuritiba.vteximg.com.br/arquivos/ids/1663114-1000-1000/LV417866.jpg?v=636815454000200000'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          // color: Colors.blue,
                          height: 50.h,
                          child: Text(
                            'Harry Potter',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 135.h,
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/61hH5E8xHZL.jpg'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          height: 50.h,
                          child: Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntListaDesejos extends StatelessWidget {
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 265.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Lista de Desejos',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add_circle_outline_rounded,
                    color: Colors.black, size: 32),
              ),
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 195.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://livrariascuritiba.vteximg.com.br/arquivos/ids/1663114-1000-1000/LV417866.jpg?v=636815454000200000'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          // color: Colors.blue,
                          height: 50.h,
                          child: Text(
                            'Harry Potter',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 135.h,
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/61hH5E8xHZL.jpg'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          height: 50.h,
                          child: Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntMeusAnuncios extends StatelessWidget {
  Widget build(BuildContext contexto) {
    return Container(
      width: 340.w,
      height: 265.h,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 345.w,
              child: Text(
                'Meus Anúncios',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add_circle_outline_rounded,
                    color: Colors.black, size: 32),
              ),
            ),
          ]),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 195.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://livrariascuritiba.vteximg.com.br/arquivos/ids/1663114-1000-1000/LV417866.jpg?v=636815454000200000'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          // color: Colors.blue,
                          height: 50.h,
                          child: Text(
                            'Harry Potter',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 135.h,
                  width: 135.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 135.h,
                        child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/61hH5E8xHZL.jpg'),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                          height: 50.h,
                          child: Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
