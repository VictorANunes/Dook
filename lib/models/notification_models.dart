class Notification2 {
  final String titulo;
  final String msg;
  final String tipoMensagem;
  final String email;
  final int data;

  Notification2(
      {this.titulo, this.msg, this.tipoMensagem, this.email, this.data});

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'msg': msg,
      'tipoMensagem': tipoMensagem,
      'email': email,
      'data': data
    };
  }

  Notification2.fromFirestore(Map<String, dynamic> firestore)
      : titulo = firestore['titulo'],
        msg = firestore['msg'],
        tipoMensagem = firestore['tipoMensagem'],
        email = firestore['email'],
        data = firestore['data'];
}
