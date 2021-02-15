import 'dart:convert';
import 'package:hemopa_app/models/checkinDoacao.dart';
import 'package:hemopa_app/provider/requestStatus.dart';
import 'package:http/http.dart' as http;

class DadosCheckin {
  static const _dartSUrl = 'https://hemopa-final-default-rtdb.firebaseio.com/';
  static final _headers = {'Content-Type': 'application/json'};

  HttpRequestStatus httpRequestStatus = HttpRequestStatus.NOT_DONE;

  Future<List<Checkin>> readCheckin() async {
    final response = await http.get(_dartSUrl);
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<Checkin> checkinList = createCheckList(responseJson);
    return checkinList;
  }

  List<Checkin> createCheckList(List data) {
    List<Checkin> list = new List();

    for (int i = 0; i < data.length; i++) {
      int idCheckin = data[i]["idCheckin"];
      bool check = data[i]["check"];

      Checkin checkin = new Checkin(idCheckin: idCheckin, check: check);
      list.add(checkin);
    }
    return list;
  }

  //criar user doador:
  Future createCheckin(Checkin checkin) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final response = await http.post(_dartSUrl,
        headers: _headers, body: json.encode({'check': checkin.check}));
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }

    return httpRequestStatus;
  }

  //deleta user doador:
  Future deleteCheckin(int idCheckin) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final url = '$_dartSUrl/$idCheckin';
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
