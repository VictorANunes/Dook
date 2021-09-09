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
  final String generos1;
  final String generos2;
  final String generos3;
  final String generos4;
  final String generos5;
  final String livros1;
  final String livros2;
  final String livros3;
  final String livros4;
  final String livros5;

  Users({
    this.nome,
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
    this.url,
    this.generos1,
    this.generos2,
    this.generos3,
    this.generos4,
    this.generos5,
    this.livros1,
    this.livros2,
    this.livros3,
    this.livros4,
    this.livros5,
  });

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'nome': nome,
      'sexo': sexo,
      'foto': url,
      'datanasc': datanasc,
      'telefone': telefone,
      'endereco': {
        'cep': cep,
        'rua': rua,
        'bairro': bairro,
        'numero': numero,
        'complemento': complemento,
        'estado': estado,
        'uf': uf
      },
      'generosInteresse': {
        'generos1': generos1,
        'generos2': generos2,
        'generos3': generos3,
        'generos4': generos4,
        'generos5': generos5,
      },
      'livrosInteresse': {
        'livros1': livros1,
        'livros2': livros2,
        'livros3': livros3,
        'livros4': livros4,
        'livros5': livros5,
      }
    };
  }

/*  Users.fromFirestore(Map<String, dynamic> firestore)
      : nome = firestore['nome']*/
}
