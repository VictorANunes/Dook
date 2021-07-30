class Users {
  final String nome;
  final int idade;

  Users({this.nome, this.idade});

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'idade': idade};
  }

  Users.fromFirestore(Map<String, dynamic> firestore)
      : nome = firestore['nome'],
        idade = firestore['idade'];
}
