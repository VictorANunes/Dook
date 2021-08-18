class Users {
  final String nome;
  final String email;
  final String senha;

  Users({this.nome, this.email, this.senha});

  Map<String, dynamic> toMap() {
    return {'nome': nome};
  }

/*  Users.fromFirestore(Map<String, dynamic> firestore)
      : nome = firestore['nome']*/
}
