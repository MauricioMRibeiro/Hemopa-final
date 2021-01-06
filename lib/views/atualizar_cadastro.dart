import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemopa_app/models/user.dart';
import 'package:hemopa_app/provider/users.dart';
import 'package:hemopa_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'dados_usuario.dart';

class AtualizarCadastro extends StatelessWidget {
  final User user;

  const AtualizarCadastro({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _nome;

    final Users users = Provider.of(context);
    // final User user = ModalRoute.of(context).settings.arguments;
    //_loadformdata(user);

    // ignore: todo
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Atualizar Cadastro",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.red[800],
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 40,
            left: 40,
            right: 40,
          ),
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 1),
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("imagem/logo.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Dados Pessoais',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "Nome: " + user.nome.toUpperCase(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome invalido';
                  }

                  if (value.trim().length <= 3) {
                    return 'Nome muito pequeno.';
                  }
                  return null;
                },
                onSaved: (value) => _nome = value,

              ),
              SizedBox(
                height: 5,
              ),
              //inseri novos dados:
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Nascimento: " + user.datanasc,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'data invalida';
                  }

                  if (value.trim().length <= 8) {
                    return 'data muito pequena.';
                  }
                  return null;
                },
                //onSaved: (value) => _formdata['datanasc'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'CPF: ' + user.cpf,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'cpf invalido';
                  }
                  if (value.trim().length <= 11) {
                    return 'cpf invalido!';
                  }
                  return null;
                },
                //onSaved: (value) => _formdata['cpf'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'RG: ' + user.rg,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'RG invalido';
                  }
                  if (value.trim().length >= 20) {
                    return 'RG invalido!';
                  }
                  return null;
                },
                //onSaved: (value) => _formdata['rg'] = value,
              ),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'E-mail: ' + user.email,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'e-mail invalido';
                  }

                  if (value.trim().length <= 3) {
                    return 'e-mail muito pequeno.';
                  }
                  return null;
                },
                //onSaved: (value) => _formdata['email'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'CEP: ' + user.cep,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                //onSaved: (value) => _formdata['cep'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Endereço:' + user.endereco,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                //onSaved: (value) => _formdata['endereco'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Nº:' + user.numero,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                //onSaved: (value) => _formdata['numero'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Bairro: ' + user.bairro,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                //onSaved: (value) => _formdata['bairro'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Cidade: ' + user.cidade,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                //onSaved: (value) => _formdata['cidade'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Estado: ' + user.uf,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                //onSaved: (value) => _formdata['uf'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Celular: ' + user.celular,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                //onSaved: (value) => _formdata['celular'] = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: 'Telefone: ' + user.telefone,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                style: TextStyle(fontSize: 20),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                //onSaved: (value) => _formdata['telefone'] = value,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Atualizar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DadosUsuario(user: user)))
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
