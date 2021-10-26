import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/models/user_models.dart';
import 'package:dook/screens/perfil/meuperfil_editar.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerfilScreen extends StatefulWidget {
  var email;
  PerfilScreen({this.email});
  @override
  Perfil createState() => Perfil(email: email);
}

class Perfil extends State {
  var email;
  Perfil({this.email});
  //Inicia a tela chamando as demais classes com os Widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            PerfilCabecalho(email: email),
            PerfilLivrosDoados(email: email),
            PerfilLivrosRecebidos(email: email)
          ],
        ),
      ),
    );
  }
}

class PerfilCabecalho extends StatelessWidget {
  var email;
  PerfilCabecalho({this.email});
  //Monta o cabeçalho da pagina
  FirestoreService firestore = new FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        //Stack usado para fazer este efeito da cor roxa
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            //Criado Container da cor roxa e seu tamanho
            color: Colors.deepPurple[600],
            height: 220.0.h,
          ),
          Row(
            //Linhas para colocar os Icones e o Texto centralizados
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //Botão de voltar para a página anterior
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/images/icons/voltarbranco.png',
                    height: 25.h,
                    width: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                width: 90.w,
              ),
              Container(
                //Texto central 'Perfil'
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp,
                  ),
                ),
              ),
              Container(
                width: 90.w,
              )
            ],
          ),
          Row(
            //Linha com espaços vazios e a foto circurlar para centralizar
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(' '),
              StreamBuilder(
                  //Stream que pega os dados do usuário para resgatar a url da foto
                  stream: firestore
                      .getUsuario(email), //função que pega os dados do usuario
                  builder:
                      (BuildContext context, AsyncSnapshot<Users> usuario) {
                    if (usuario.connectionState == ConnectionState.waiting) {
                      return new Center(child: new CircularProgressIndicator());
                    }
                    if (usuario.hasData) {
                      //Verifica se tem data
                      return Container(
                        //Mostrar foto de perfil redonda
                        margin: EdgeInsets.symmetric(vertical: 100.0.r),
                        width: 170.w,
                        height: 170.h,
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
                                image: NetworkImage(usuario.data
                                    .url), //Pegar imagem através de um link
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      //Caso a foto demore para carregar coloca esta no lugar até carregar
                      return Container(
                        width: 170.w,
                        height: 170.h,
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
                                image: NetworkImage(
                                    'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg'),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
              Text(' '),
            ],
          ),
          Container(
            //Resgata e mostra dados do usuário como nome e cidade
            margin: EdgeInsets.only(top: 270.0),
            width: 431.w,
            height: 120.h,
            //color: Colors.yellow,
            child: Container(
              padding: EdgeInsets.only(
                top: 10.r,
                left: 25.r,
                right: 25.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      //Stream para resgatar os dados do usuário
                      stream: firestore.getUsuario(email),
                      builder:
                          (BuildContext context, AsyncSnapshot<Users> usuario) {
                        if (usuario.hasData) {
                          //Cortar o nome pegando o primeiro e ultimo nome da pessoa
                          String nome3 = '';
                          String nome = usuario.data.nome;
                          List<String> nome2 = nome.split(" ");
                          if (nome2[0] != nome2[nome2.length - 1]) {
                            nome3 = nome2[0] + " " + nome2[nome2.length - 1];
                          } else {
                            nome3 = nome2[0];
                          }

                          //Pegar avaliacao
                          List<int> avaliacao = usuario.data.avaliacao;
                          int soma = 0;
                          var media = 5.0;
                          if (avaliacao.isEmpty == false) {
                            for (int i = 0; i < avaliacao.length; i++) {
                              soma = soma + avaliacao[i];
                            }
                            media = (soma / avaliacao.length).toDouble();
                          }

                          return Column(
                            children: <Widget>[
                              Text(nome3, //Mostra o nome
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  usuario.data.cidade +
                                      ", " +
                                      usuario.data.uf, //Mostra cidade e estado
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  )),
                              Container(
                                  //Mostra a avaliação da pessoa em estrelas
                                  margin: EdgeInsets.symmetric(vertical: 5.0.r),
                                  child: RatingBarIndicator(
                                    rating: media,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.deepPurple[600],
                                    ),
                                    itemCount: 5,
                                    itemSize: 27.0.sp,
                                    direction: Axis.horizontal,
                                  )),
                            ],
                          );
                        } else {
                          return Text('');
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PerfilLivrosDoados extends StatelessWidget {
  var email;
  PerfilLivrosDoados({this.email});
  //Parte que mostra os Livros Doados no Perfil
  @override
  FirestoreService firestore = new FirestoreService();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15.r,
        right: 15.r,
      ),
      width: 340.w,
      height: 265.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Livros Doados',
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 210.h,
            child: StreamBuilder(
                //Stream que pega dados do usuário
                stream: firestore.getUsuario(email),
                builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
                  if (usuario.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: usuario.data.livrosDoados
                            .length, //faz o count de acordo com a lista de livrosDoados
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              //A partir do id de exemplar armazenado em livrosDoados acessamos o exemplar
                              stream: firestore.getExemplar(
                                  usuario.data.livrosDoados[index]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Exemplar> exemplar) {
                                if (exemplar.hasData) {
                                  return StreamBuilder(
                                    //Aqui acessamos a Obra de acordo com o isbn pego no Exemplar
                                    stream:
                                        firestore.getObra(exemplar.data.isbn),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Obra> obra) {
                                      if (obra.hasData) {
                                        return Container(
                                          padding: EdgeInsets.only(right: 15.r),
                                          width: 125.w,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 145.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.r)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            exemplar
                                                                .data.capa))),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                height: 50.h,
                                                child: Text(
                                                  obra.data.titulo,
                                                  style: TextStyle(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Text('');
                                      }
                                    },
                                  );
                                } else {
                                  return Text('');
                                }
                              });
                        });
                  } else {
                    return Text('');
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class PerfilLivrosRecebidos extends StatelessWidget {
  var email;
  PerfilLivrosRecebidos({this.email});
  //Funciona igualmente o LivrosDoados
  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = new FirestoreService();
    return Container(
      padding: EdgeInsets.only(
        left: 15.r,
        right: 15.r,
      ),
      width: 340.w,
      height: 265.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Livros Recebidos',
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 210.h,
            child: StreamBuilder(
                stream: firestore.getUsuario(email),
                builder: (BuildContext context, AsyncSnapshot<Users> usuario) {
                  if (usuario.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: usuario.data.livrosRecebidos.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: firestore.getExemplar(
                                  usuario.data.livrosRecebidos[index]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Exemplar> exemplar) {
                                if (exemplar.hasData) {
                                  return StreamBuilder(
                                    stream:
                                        firestore.getObra(exemplar.data.isbn),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Obra> obra) {
                                      if (obra.hasData) {
                                        return Container(
                                          padding: EdgeInsets.only(right: 15.r),
                                          width: 125.w,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 145.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.r)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            exemplar
                                                                .data.capa))),
                                              ),
                                              SizedBox(height: 5.h),
                                              Container(
                                                height: 50.h,
                                                child: Text(
                                                  obra.data.titulo,
                                                  style: TextStyle(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Text('');
                                      }
                                    },
                                  );
                                } else {
                                  return Text('');
                                }
                              });
                        });
                  } else {
                    return Text('');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
