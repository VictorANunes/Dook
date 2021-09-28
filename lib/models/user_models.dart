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
  final String cidade;
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
    this.cidade,
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
        'cidade': cidade,
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

  Users.fromFirestore(Map<String, dynamic> firestore)
      : email = firestore['email'],
        senha = firestore['senha'],
        nome = firestore['nome'],
        cpf = firestore['cpf'],
        datanasc = firestore['datanasc'],
        sexo = firestore['sexo'],
        telefone = firestore['telefone'],
        cep = firestore['endereco']['cep'],
        rua = firestore['endereco']['rua'],
        bairro = firestore['endereco']['bairro'],
        numero = firestore['endereco']['numero'],
        complemento = firestore['endereco']['complemento'],
        cidade = firestore['endereco']['cidade'],
        uf = firestore['endereco']['uf'],
        url = firestore['foto'],
        generos1 = firestore['generosInteresse']['generos1'],
        generos2 = firestore['generosInteresse']['generos2'],
        generos3 = firestore['generosInteresse']['generos3'],
        generos4 = firestore['generosInteresse']['generos4'],
        generos5 = firestore['generosInteresse']['generos5'],
        livros1 = firestore['livrosInteresse']['livros1'],
        livros2 = firestore['livrosInteresse']['livros2'],
        livros3 = firestore['livrosInteresse']['livros3'],
        livros4 = firestore['livrosInteresse']['livros4'],
        livros5 = firestore['livrosInteresse']['livros5'];
}
