class Chat {
  final String doador;
  final String receptor;
  final String exemplar;
  final int data;

  Chat({this.doador, this.receptor, this.exemplar, this.data});

  Map<String, dynamic> toMap() {
    return {
      'doador': doador,
      'receptor': receptor,
      'exemplar': exemplar,
      'data': data,
      'mensagens': {}
    };
  }
}
