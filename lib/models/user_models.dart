class Users {
  final String nome;
  final String email;
  final String senha;
  final String cpf;
  final String datanasc;
  final String sexo;
  final String telefone;
  final String cep;
  final String rua;
  final String bairro;
  final String numero;
  final String complemento;
  final String estado;
  final String uf;
  final String url;

  Users(
      {this.nome,
      this.email,
      this.senha,
      this.cpf,
      this.datanasc,
      this.sexo,
      this.telefone,
      this.cep,
      this.rua,
      this.bairro,
      this.numero,
      this.complemento,
      this.estado,
      this.uf,
      this.url});

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'nome': nome,
      'sexo': sexo,
      'foto': url,
      'endereco': {
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'numero': numero,
        'complemento': complemento,
        'estado': estado,
        'uf': uf
      }
    };
  }

/*  Users.fromFirestore(Map<String, dynamic> firestore)
      : nome = firestore['nome']*/
}
