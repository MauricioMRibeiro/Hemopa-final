class Doacao {
  final int idDoacao;
  String tipoSangue;
  String localDoacao;
  DateTime dataDoacao;
  String horaDoacao;

  Doacao(
      {this.idDoacao,
      this.tipoSangue,
      this.localDoacao,
      this.dataDoacao,
      this.horaDoacao});

  factory Doacao.fromJson(Map<String, dynamic> json) {
    return Doacao(
        idDoacao: json['idDoacao'],
        tipoSangue: json['tipoSangue'],
        localDoacao: json['localDoacao'],
        dataDoacao: json['dataDoacao'],
        horaDoacao: json['horaDoacao']);
  }
}
