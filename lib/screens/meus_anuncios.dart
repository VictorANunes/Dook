import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/anuncio/criar_anuncio_1.dart';
import 'package:dook/screens/livro/pagina_meu_livro.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeusAnunciosScreen extends StatefulWidget {
  MeusAnuncios createState() => MeusAnuncios();
}

class MeusAnuncios extends State {
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
            MeusAnunciosCabecalho(),
            SizedBox(
              height: 25.h,
            ),
            MeusAnunciosCorpo(),
          ],
        ),
      ),
    );
  }
}

class MeusAnunciosCabecalho extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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
          child: Text(
            'Meus Anuncios',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.ssp,
            ),
          ),
        ),
        Container(
          width: 62.w,
        )
      ],
    );
  }
}

class MeusAnunciosCorpo extends StatelessWidget {
  FirestoreService firestore = FirestoreService();
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.getMeusAnuncios(),
      builder: (BuildContext context, AsyncSnapshot exemplar) {
        if (exemplar.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple[600],
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        if (exemplar.hasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: exemplar.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return StreamBuilder(
                stream: firestore.getObra(exemplar.data.docs[index]['isbn']),
                builder: (BuildContext context, AsyncSnapshot<Obra> obra) {
                  if (obra.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.deepPurple[600],
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }
                  if (obra.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MeuLivroScreen(
                                exemplar: exemplar.data.docs[index].id),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10.r),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              height: 145.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(exemplar.data.docs[index]
                                      ['fotos']['capa']),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 260.w,
                              height: 100.h,
                              child: Center(
                                child: Text(
                                  obra.data.titulo,
                                  style: TextStyle(fontSize: 22.ssp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            },
          );
        } else {
          return Column(
            children: [
              Text(
                'Você ainda não anunciou nenhum livro!',
                style: TextStyle(fontSize: 19.ssp, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 200.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CriarAnuncio1Screen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple[600],
                    minimumSize: Size(88.h, 45.h),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  child: Text(
                    'Anuncie Agora',
                    style: TextStyle(
                      fontSize: 18.ssp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
