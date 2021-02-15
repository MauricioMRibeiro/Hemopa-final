import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:hemopa_app/provider/requestStatus.dart';
import 'package:hemopa_app/data/dummy_Users.dart';
import 'package:hemopa_app/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  //static const _baseUrl = 'https://hemopa-app-default-rtdb.firebaseio.com/';
  static const _baseUrl = 'https://hemopa-final-default-rtdb.firebaseio.com/';
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

//verifica se o usuario existe
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }
// Aletra cadastro
    if (user.cpf != null &&
        // ignore: prefer_is_not_empty
        !user.cpf.trim().isEmpty &&
        _items.containsKey(user.cpf)) {
      _items.update(
        user.cpf,
        // ignore: missing_required_param
        (_) => User(
          //id: user.id,
          cpf: user.cpf,
          nome: user.nome,
          email: user.email,
          telefone: user.telefone,
          endereco: user.endereco,
          senha: user.senha,
          datanasc: user.datanasc,
          rg: user.rg,
          cep: user.cep,
          cidade: user.cidade,
          uf: user.uf,
          numero: user.numero,
          bairro: user.bairro,
          sexo: user.sexo,
          celular: user.celular,
          datadoacao: user.datadoacao,
          horadoacao: user.horadoacao,
          unidadedoacao: user.unidadedoacao,
        ),
      );
    } else {
      final response = await http.post(
        "$_baseUrl/user.json",
        body: json.encode({
          'cpf': user.cpf,
          'nome': user.nome,
          'email': user.email,
          //'id': user.id,
          'telefone': user.telefone,
          'endereco': user.endereco,
          'senha': user.senha,
          'datanasc': user.datanasc,
          'rg': user.rg,
          'cep': user.cep,
          'cidade': user.cidade,
          'uf': user.uf,
          'numero': user.numero,
          'bairro': user.bairro,
          'sexo': user.sexo,
          'celular': user.celular,
          'datadoacao': user.datadoacao,
          'horadoacao': user.horadoacao,
          'unidadedoacao': user.unidadedoacao,
        }),
      );

      final id = json.decode(response.body)['nome'];
      // adicionar
      _items.putIfAbsent(
        id,
        // ignore: missing_required_param
        () => User(
          //id: id,
          cpf: user.cpf,
          nome: user.nome,
          email: user.email,
          telefone: user.telefone,
          endereco: user.endereco,
          senha: user.senha,
          datanasc: user.datanasc,
          rg: user.rg,
          cep: user.cep,
          cidade: user.cidade,
          uf: user.uf,
          numero: user.numero,
          bairro: user.bairro,
          sexo: user.sexo,
          celular: user.celular,
          datadoacao: user.datadoacao,
          horadoacao: user.horadoacao,
          unidadedoacao: user.unidadedoacao,
        ),
      );
    }
    // ou alterar

    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.cpf != null) {
      _items.remove(user.cpf);
      notifyListeners();
    }
  }

  /*
  class Users with ChangeNotifier {
  static const _dartSUrl = ''https://hemopa-final-default-rtdb.firebaseio.com/';
  static final _headers = {'Content-Type': 'application/json'};

  HttpRequestStatus httpRequestStatus = HttpRequestStatus.NOT_DONE;

  Future<List<User>> readDoadores() async {
    final response = await http.get(_dartSUrl);
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<User> userList = createDoadoresList(responseJson);
    return userList;
  }

  List<User> createDoadoresList(List data) {
    List<User> list = new List();

    for (int i = 0; i < data.length; i++) {
      int id = data[i]["id"];
      String cpf = data[i]["cpf"];
      String nome = data[i]["nome"];
      DateTime datanasc = data[i]["datanasc"];
      String sexo = data[i]["sexo"];
      String telefone = data[i]["telefone"];
      String celular = data[i]["celular"];
      String email = data[i]["email"];
      String senha = data[i]["senha"];
      Doador doador = new Doador(
          id: id,
          cpf: cpf,
          nome: nome,
          datanasc: datanasc,
          sexo: sexo,
          telefone: telefone,
          celular: celular,
          email: email,
          senha: senha);
      list.add(doador);
    }
    return list;
  }

  //criar user doador:
  Future createDoador(User user) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final response = await http.post(_dartSUrl,
        headers: _headers,
        body: json.encode({
          'cpf': user.cpf,
          'nome': user.nome,
          'datanasc': user.datanasc,
          'sexo': user.sexo,
          'telefone': user.telefone,
          'celular': user.celular,
          'email': user.email,
          'senha': user.senha
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
  Future deleteDoador(int id) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final url = '$_dartSUrl/$id';
    final response = await http.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }
    return httpRequestStatus;
  }

  // atualiza user Doador:
  /* Future updateDoador(User user) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final url = '$_dartSUrl/$user.id';
    final response = await http.put(url,
        headers: _headers,
        body: json.encode({
          'cpf': user.cpf,
          'nome': user.nome,
          'datanasc': user.datanasc,
          'sexo': user.sexo,
          'telefone': user.telefone,
          'celular': user.celular,
          'email': user.email,
          'senha': user.senha
        }));
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }
  } */
  Future updateDoador(
      int id,
      String cpf,
      String nome,
      String datanasc,
      String sexo,
      String telefone,
      String celular,
      String email,
      String senha) async {
    httpRequestStatus = HttpRequestStatus.NOT_DONE;
    final url = '$_dartSUrl/$id';
    final response = await http.put(url,
        headers: _headers,
        body: json.encode({
          'cpf': cpf,
          'nome': nome,
          'datanasc': datanasc,
          'sexo': sexo,
          'telefone': telefone,
          'celular': celular,
          'email': email,
          'senha': senha
        }));
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.DONE;
    } else {
      httpRequestStatus = HttpRequestStatus.ERROR;
    }
  }
}

  */

}
