import 'package:dook/models/user_models.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvaliacaoScreen extends StatefulWidget {
  var doador;
  AvaliacaoScreen({this.doador});
  Avaliacao createState() => Avaliacao(doador: doador);
}

class Avaliacao extends State {
  var doador;
  Avaliacao({this.doador});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 30.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: [
            AvaliacaoCabecalho(),
            SizedBox(
              height: 40.h,
            ),
            AvaliacaoCorpo(doador: doador),
          ],
        ),
      ),
    );
  }
}

class AvaliacaoCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Avaliar',
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AvaliacaoCorpo extends StatelessWidget {
  var doador;
  AvaliacaoCorpo({this.doador});

  FirestoreService firestore = FirestoreService();

  final TextEditingController text = TextEditingController();

  var nota = 5.0;

  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: firestore.getUsuario(doador),
        builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
          if (usuario.hasData) {
            return ListView(
              shrinkWrap: true,
              children: [
                Container(
                  //Mostrar foto de perfil redonda
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.r),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(usuario
                              .data.url), //Pegar imagem através de um link
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 40.sp,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.deepPurple[600],
                    ),
                    onRatingUpdate: (rating) {
                      nota = rating;
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    'Deixe um comentário:',
                    style: TextStyle(
                      fontSize: 27.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: text,
                  minLines: 7,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 20.r,
                      bottom: 20.r,
                      left: 15.r,
                      right: 15.r,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.yellow)),
                    labelText: "Escreva Aqui",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[600],
                    minimumSize: Size(382.h, 55.h),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  onPressed: () {
                    print(nota.toInt());
                    List<int> avaliacao = usuario.data.avaliacao;
                    avaliacao.add(nota.toInt());
                    firestore.updateAvaliacao(doador, avaliacao);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuInferiorScreen()));
                  },
                  child: Text(
                    'Enviar',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple[600],
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
