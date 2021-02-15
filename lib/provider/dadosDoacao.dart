import 'dart:convert';
import 'package:hemopa_app/models/doacao.dart';
import 'package:hemopa_app/provider/requestStatus.dart';
import 'package:http/http.dart' as http;

class DadosDoacao {
  static const _dartSUrl = 'https://hemopa-final-default-rtdb.firebaseio.com/';
  static final _headers = {'Content-Type': 'application/json'};

  HttpRequestStatus httpRequestStatus = HttpRequestStatus.NOT_DONE;

  Future<List<Doacao>> readDoacoes() async {
    final response = await http.get(_dartSUrl);
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<Doacao> doacaoList = createDoacaoList(responseJson);
    return doacaoList;
  }

  List<Doacao> createDoacaoList(List data) {
    List<Doacao> list = new List();

    for (int i = 0; i < data.length; i++) {
      int idDoacao = data[i]["idDoacao"];
      String tipoSangue = data[i]["tipoSangue"];
      String localDoacao = data[i]["localDoacao"];
      DateTime dataDoacao = data[i]["dataDoacao"];
      String horaDoacao = data[i]["horaDoacao"];

      Doacao doacao = new Doacao(
          idDoacao: idDoacao,
          tipoSangue: tipoSangue,
          localDoacao: localDoacao,
          dataDoacao: dataDoacao,
          horaDoacao: horaDoacao);
      list.add(doacao);
    }
    return list;
  }

  //criar user doador:
  Future createDoacao(Doacao doacao) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final response = await http.post(_dartSUrl,
        headers: _headers,
        body: json.encode({
          'tipoSangue': doacao.tipoSangue,
          'localDoacao': doacao.localDoacao,
          'dataDoacao': doacao.dataDoacao,
          'horaDoacao': doacao.horaDoacao
        }));
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }

    return httpRequestStatus;
  }

  //deleta user doador:
  Future deleteDoacao(int idDoacao) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final url = '$_dartSUrl/$idDoacao';
    final response = await http.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }
    return httpRequestStatus;
  }
}
