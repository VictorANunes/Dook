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
  final List<String> generos;
  final List<String> livros;
  final String id;
  List<String> livrosDoados = [];
  List<String> livrosRecebidos = [];
  List<int> avaliacao = [];
  bool notificacao;

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
      this.cidade,
      this.uf,
      this.url,
      this.generos,
      this.livros,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'generosInteresse': generos,
      'livrosInteresse': livros,
      'livrosDoados': [],
      'livrosRecebidos': [],
      'avaliacao': [],
      'notificacao': true
    };
  }

  Users.fromFirestore(Map<String, dynamic> firestore, String id)
      : email = id,
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
        generos = List.from(firestore['generosInteresse']),
        livros = List.from(firestore['livrosInteresse']),
        id = firestore['id'],
        livrosDoados = List.from(firestore['livrosDoados']),
        livrosRecebidos = List.from(firestore['livrosRecebidos']),
        avaliacao = List.from(firestore['avaliacao']),
        notificacao = firestore['notificacao'];
}
