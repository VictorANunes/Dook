import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:dook/models/book_models.dart';
import 'package:dook/models/chat_models.dart';
import 'package:dook/models/exemplar_models.dart';
import 'package:dook/models/notification_models.dart';
import 'package:dook/models/obra_models.dart';
import 'package:dook/provider/exemplar_provider.dart';
import 'package:dook/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dook/models/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

class FirestoreService extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
//FirebaseFirestore.instance.collection('collection_Name').doc('doc_Name').collection('collection_Name').doc(code.documentId).update({'redeem': true});

  String getEmail() {
    var currentUser = FirebaseAuth.instance.currentUser;
    var email;
    if (currentUser != null) {
      email = currentUser.email;
    } else {
      email = null;
    }
    return email;
  }

  //----------LOGIN----------//
  Future<bool> LoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        //deslogado
        return false;
      } else if (user != null) {
        //logado
        return true;
      }
    });
    notifyListeners();
  }

  Future<void> SignOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  //----------USUÁRIOS----------//
  Future<void> saveUser(Users user) async {
    //Salvar usuário no Firebase
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.senha);
    try {
      _db.collection('Usuario').doc(user.email).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Users>> getDataUser(String email) {
    //Pegar todos usuários cadastrados
    return _db.collection('Usuario').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Users.fromFirestore(document.data(), document.id))
        .toList());
  }

  void removeUser() async {
    var email = getEmail();
    _db.collection('Usuario').doc(email).delete();

    var not = await _db
        .collection('Notificacao')
        .where('email', isEqualTo: email)
        .get();

    for (var i = 0; i < not.docs.length; i++) {
      _db.collection('Notificacao').doc(not.docs[i].id).delete();
    }

    var exe1 = await _db
        .collection('Exemplar')
        .where('criador', isEqualTo: email)
        .get();

    for (var i = 0; i < exe1.docs.length; i++) {
      _db.collection('Exemplar').doc(exe1.docs[i].id).delete();
    }

    var result = await _db
        .collection('Exemplar')
        .where('listaEspera', arrayContains: email)
        .get();

    for (var i = 0; i < result.docs.length; i++) {
      List<String> lista = List<String>.from(result.docs[i]['listaEspera']);
      for (var j = 0; j < lista.length; j++) {
        if (lista[j] == email) {
          lista.removeAt(j);
          updateListaEspera(result.docs[i].id, lista);
        }
      }
    }

    var chat1 =
        await _db.collection('Chat').where('doador', isEqualTo: email).get();
    for (var i = 0; i < chat1.docs.length; i++) {
      _db.collection('Chat').doc(chat1.docs[i].id).delete();
    }

    var chat2 =
        await _db.collection('Chat').where('receptor', isEqualTo: email).get();
    for (var i = 0; i < chat2.docs.length; i++) {
      _db.collection('Chat').doc(chat2.docs[i].id).delete();
    }

    try {
      FirebaseAuth.instance.currentUser.delete();
    } catch (e) {
      print(e.toString());
    }
    SignOut();
  }

  Stream<Users> getDadosUsuario() {
    //Pegar dados do prório usuário pegando seu próprio e-mail
    var email = getEmail();
    final result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data(), event.id));
    return result;
  }

  Stream<Users> getUsuario(email) {
    //Pegar dados de outro usuário através de seu ID(Email)
    var result = _db
        .collection('Usuario')
        .doc(email)
        .snapshots()
        .map((event) => Users.fromFirestore(event.data(), event.id));
    return result;
  }

  void updateListaDoados(String email, String exemplar) async {
    var result = await _db.collection('Usuario').doc(email).get();
    var livrosDoados = await result.data()['livrosDoados'];
    livrosDoados.add(exemplar);
    print(livrosDoados);
    _db.collection('Usuario').doc(email).update({'livrosDoados': livrosDoados});
  }

  void updateListaRecebido(String email, String exemplar) async {
    var result = await _db.collection('Usuario').doc(email).get();
    var livrosRecebidos = await result.data()['livrosRecebidos'];
    livrosRecebidos.add(exemplar);
    print(livrosRecebidos);
    _db
        .collection('Usuario')
        .doc(email)
        .update({'livrosRecebidos': livrosRecebidos});
  }

  void updateGenInt(List<String> generos) {
    _db
        .collection('Usuario')
        .doc(getEmail())
        .update({'generosInteresse': generos});
  }

  void updateLivrosInt(List<String> livros) {
    _db
        .collection('Usuario')
        .doc(getEmail())
        .update({'livrosInteresse': livros});
  }

  void updateAvaliacao(String email, List<int> avaliacao) {
    _db.collection('Usuario').doc(email).update({'avaliacao': avaliacao});
  }

  void updateUser(
      String nome,
      String cpf,
      String dataNasc,
      String telefone,
      String cep,
      String rua,
      String bairro,
      String numero,
      String complemento,
      String cidade,
      String uf,
      String url) {
    String email = getEmail();
    if (nome != '') {
      _db.collection('Usuario').doc(email).update({'nome': nome});
    }
    if (dataNasc != '') {
      _db.collection('Usuario').doc(email).update({'datanasc': dataNasc});
    }
    if (telefone != '') {
      _db.collection('Usuario').doc(email).update({'telefone': telefone});
    }
    _db.collection('Usuario').doc(email).update({
      'endereco': {
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'numero': numero,
        'complemento': complemento,
        'cidade': cidade,
        'uf': uf
      }
    });

    _db.collection('Usuario').doc(email).update({'cpf': cpf});

    _db.collection('Usuario').doc(email).update({'foto': url});
  }

  void getUsersWithLivrosInt(String isbn) async {
    NotificationService ns = NotificationService();

    var result = await _db.collection('Obra').doc(isbn).get();
    String titulo = result.data()['titulo'];

    titulo = titulo.toLowerCase();

    var result2 = await _db
        .collection('Usuario')
        .where('livrosInteresse', arrayContains: titulo)
        .get();

    for (var i in result2.docs) {
      ns.sendNotification(
          'Livro Disponível',
          'Um livro da sua lista de desejos está disponível!',
          i.id,
          'Livro Disponivel');
    }
  }

  //----------OBRA----------//
  Future<void> saveObra(Obra obra) async {
    //Salvar Obra no Firebase
    try {
      await _db
          .collection('Obra')
          .doc(obra.isbn)
          .set(obra.toMap(pesqList(obra.titulo, obra.editora, obra.autor)));
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> resultadoPesquisa(texto) {
    //Mostrar o resultado da pesquisa
    final result = _db
        .collection('Obra')
        .where('pesqList', arrayContains: texto)
        .limit(15)
        .snapshots();
    return result;
  }

  List<String> pesqList(String titulo, String editora, String autor) {
    String s = "";
    String s2 = "";
    if (titulo != null) {
      s = s + titulo + ",";
      s2 = s2 + titulo + " ";
    }
    if (autor != null) {
      s = s + autor;
      s2 = s2 + autor;
    }

    List<String> splitList = s.split(",") + s2.split(" ");
    List<String> pesqList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + 1; j++) {
        pesqList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }

    return pesqList;
  }

  Stream<Obra> getObra(String isbn) {
    //Pegar uma Obra de acordo com seu ID (isbn)
    var result = _db
        .collection('Obra')
        .doc(isbn)
        .snapshots()
        .map((event) => Obra.fromFirestore(event.data()));
    return result;
  }

  Future<Book> getBook(String isbn) async {
    //Pegar uma Obra de acordo com seu ID (isbn)
    var result = await _db.collection('Obra').doc(isbn).get();
    print(result.exists);
    Book book;
    if (result.exists) {
      book = Book.fromFirestore(result.data());
    } else {
      book = null;
    }
    return book;
  }

  //----------EXEMPLAR----------//
  Future<void> saveExemplar(Exemplar exemplar) async {
    //Salvar Exemplar no Firebase
    var lastId = await _db
        .collection("Exemplar")
        .orderBy(FieldPath.documentId, descending: false)
        .get()
        .then((value) => value.docs.last.id);

    var id = int.parse(lastId) + 1;
    try {
      await _db.collection('Exemplar').doc(id.toString()).set(exemplar.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> pesquisaExemplar(String isbn) {
    //Mostrar o resultado da pesquisa de acordo com o isbn do livro e o status aberto do Exemplar
    final result = _db
        .collection('Exemplar')
        .where('isbn', isEqualTo: isbn)
        .where('status', isEqualTo: 'aberto')
        .snapshots();
    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMeusAnuncios() {
    //Pegar os Exemplares com o criador igual ao seu e-mail
    String email = getEmail();
    var result = _db
        .collection('Exemplar')
        .where('criador', isEqualTo: email)
        .snapshots();
    return result;
  }

  Stream<Exemplar> getExemplar(String id) {
    //Pegar Exemplar através de seu ID
    var result = _db
        .collection('Exemplar')
        .doc(id)
        .snapshots()
        .map((event) => Exemplar.fromFirestore(event.data()));
    return result;
  }

  void updateStatusExemplar(String id, String status) {
    _db.collection('Exemplar').doc(id).update({'status': status});
  }

  void updateListaEspera(String id, List<String> listaEspera) {
    _db.collection('Exemplar').doc(id).update({'listaEspera': listaEspera});
  }

  void updateFotos(String id, String capa, String contracapa, String lombada,
      String corteSuperior, String corteDianteiro, String corteInferior) {
    _db.collection('Exemplar').doc(id).update({
      'fotos': {
        'capa': capa,
        'contracapa': contracapa,
        'lombada': lombada,
        'cortesuperior': corteSuperior,
        'cortedianteiro': corteDianteiro,
        'corteinferior': corteInferior
      }
    });
  }

  Future<List<String>> getListaEspera(String id) async {
    var result = await _db.collection('Exemplar').doc(id).get();
    print(result.data()['listaEspera']);
    Exemplar exemplar = Exemplar.fromFirestore(result.data());
    return exemplar.listaEspera;
  }

  Future<List<String>> getExemplaresGeneros(List<String> generos) async {
    List<String> exemplares = [];
    List<String> isbn = [];
    var result;

    for (var i in generos) {
      result = await _db
          .collection('Obra')
          .where('categoria', arrayContains: i)
          .limit(20)
          .get();
      for (int i = 0; i < result.docs.length; i++) {
        if (!isbn.contains(result.docs[i].id)) {
          isbn.add(result.docs[i].id);
        }
      }
    }
    for (var i in isbn) {
      result = await _db
          .collection('Exemplar')
          .where('isbn', isEqualTo: i)
          .where('status', isEqualTo: 'aberto')
          .limit(3)
          .get();
      for (int i = 0; i < result.docs.length; i++) {
        if (!isbn.contains(result.docs[i].id)) {
          exemplares.add(result.docs[i].id);
        }
      }
    }

    exemplares.shuffle();
    if (exemplares.isEmpty) {
      return null;
    } else {
      return exemplares;
    }
  }

  Future<List<String>> getExemplaresLivros(List<String> livros) async {
    List<String> exemplares = [];
    List<String> isbn = [];
    var result;

    for (var i in livros) {
      i = i.toLowerCase();
      var result = await _db
          .collection('Obra')
          .where('pesqList', arrayContains: i)
          .limit(20)
          .get();
      for (int i = 0; i < result.docs.length; i++) {
        if (!isbn.contains(result.docs[i].id)) {
          isbn.add(result.docs[i].id);
        }
      }
    }

    for (var i in isbn) {
      result = await _db
          .collection('Exemplar')
          .where('isbn', isEqualTo: i)
          .where('status', isEqualTo: 'aberto')
          .limit(3)
          .get();
      for (int i = 0; i < result.docs.length; i++) {
        if (!isbn.contains(result.docs[i].id)) {
          exemplares.add(result.docs[i].id);
        }
      }
    }

    exemplares.shuffle();
    if (exemplares.isEmpty) {
      return null;
    } else {
      return exemplares;
    }
  }

  void deleteExemplar(String id) {
    _db.collection('Exemplar').doc(id).delete();
  }

  void updateRespostas(String exemplar, List<double> respostas) {
    Map<String, dynamic> map = {
      'resp1': respostas[0].toInt().toString(),
      'resp2': respostas[1].toInt().toString(),
      'resp3': respostas[2].toInt().toString(),
      'resp4': respostas[3].toInt().toString(),
      'resp5': respostas[4].toInt().toString()
    };
    _db.collection('Exemplar').doc(exemplar).update({'respostas': map});
  }

  //----------CHAT----------//
  void saveChat(Chat chat) async {
    //Salvar chat no Firebase
    _db
        .collection('Chat')
        .doc(chat.doador + " - " + chat.receptor)
        .set(chat.toMap());
  }

  void salvarMensagem(ChatMessage msg, String doador, String receptor) async {
    Map<String, dynamic> mensagens;
    Map<String, dynamic> msg2;

    mensagens = await _db //Pegar mensagens que ja estao salvas
        .collection('Chat')
        .doc(doador + " - " + receptor)
        .get()
        .then((value) => value.data());

    msg2 = mensagens['mensagens'];

    msg2.addAll(
        //Adicionar a mensagem nova na lista de mensagens que ja estao salvas
        {DateTime.now().millisecondsSinceEpoch.toString(): msg.toJson()});

    _db //salvar as mensagens novamente com a mensagem nova
        .collection('Chat')
        .doc(doador + " - " + receptor)
        .update({'mensagens': msg2});

    updateData(DateTime.now().millisecondsSinceEpoch, doador, receptor);
  }

  void updateData(int data, String doador, String receptor) {
    _db
        .collection('Chat')
        .doc(doador + " - " + receptor)
        .update({'data': data});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChat(
      String doador, String receptor) {
    //Recuperar mensagens da conversa
    var result =
        _db.collection('Chat').doc(doador + " - " + receptor).snapshots();

    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listarConversas() {
    var email = getEmail();

    var result =
        _db.collection('Chat').where('doador', isEqualTo: email).snapshots();

    return result;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listarConversas2() {
    var email = getEmail();

    var result2 =
        _db.collection('Chat').where('receptor', isEqualTo: email).snapshots();

    return result2;
  }

  void removeChat(String doador, String receptor) {
    _db.collection('Chat').doc(doador + " - " + receptor).delete();
  }

  void deleteChatWithExemplar(String exemplar) async {
    var result =
        await _db.collection('Chat').where({'exemplar': exemplar}).get();
    for (var i in result.docs) {
      _db.collection('Chat').doc(i.id).delete();
    }
  }

  void saveNotification(Notification2 not) {
    _db.collection('Notificacao').doc().set(not.toMap());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNotification(
      String email) async {
    var result = await _db
        .collection('Notificacao')
        .where('email', isEqualTo: email)
        .get();
    return result;
  }

  void updateNotificacao(bool status) {
    _db.collection('Usuario').doc(getEmail()).update({'notificacao': status});
  }

  //Recuperar dados e salvar em uma variável
  Future<String> testeUser() async {
    var result = await _db
        .collection('Usuario')
        .doc('luis@gmail.com')
        .snapshots()
        .map((snapshot) => testeUser2(snapshot.data()))
        .first;
  }

  void testeUser2(Map<String, dynamic> firestore) {
    List<String> livrosDoados = List.from(firestore['livrosDoados']);
    //String nome = firestore['nome'];
    //return nome;
  }

  //LOGIN GOOGLE
  /*Future<String> signInwithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }*/
}
