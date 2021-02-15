//import 'dart:html';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hemopa_app/models/user.dart';
import 'package:hemopa_app/provider/users.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;
  final format = DateFormat("dd/MM/yyyy");

  String _sexo;
  List _listSexo = ['Feminino', 'Masculino'];

  DateTime _data = new DateTime.now();

  // ignore: unused_field
  String _dateConvert;
  DateTime _vDate;

  final Map<String, String> _formdata = {};
  //final Map<DateTime, DateTime> _formdate = {};

  // ignore: unused_element
  void _loadformdata(User user) {
    // _formdata['id'] = user.id;
    _formdata['cpf'] = user.cpf;
    _formdata['nome'] = user.nome;
    _formdata['email'] = user.email;
    _formdata['avatarUrl'] = user.avatarUrl;
    _formdata['endereco'] = user.endereco;
    _formdata['telefone'] = user.telefone;
    _formdata['senha'] = user.senha;
    //inseri novos dados:
    _formdata['datanasc'] = user.datanasc;
    //_formdate[_vDate] = user.datanasc;
    _formdata['rg'] = user.rg;
    _formdata['cep'] = user.cep;
    _formdata['cidade'] = user.cidade;
    _formdata['uf'] = user.uf;
    _formdata['numero'] = user.numero;
    _formdata['bairro'] = user.bairro;
    _formdata['sexo'] = user.sexo;
    _formdata['celular'] = user.celular;
  }

  @override
  Widget build(BuildContext context) {
    //final User user = ModalRoute.of(context).settings.arguments;
    //_loadformdata(user);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cadastro Doador',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.green.shade100,
                size: 35.0,
              ),
              onPressed: () async {
                final isValid = _form.currentState.validate();

                if (isValid) {
                  _form.currentState.save();

                  setState(() {
                    _isLoading = true;
                  });

                  // ignore: missing_required_param
                  await Provider.of<Users>(context, listen: false).put(User(
                    cpf: _formdata['cpf'],
                    //id: _formdata['id'],
                    nome: _formdata['nome'],
                    email: _formdata['email'],
                    datanasc: _formdata['datanasc'],
                    rg: _formdata['rg'],
                    telefone: _formdata['telefone'],
                    avatarUrl: _formdata['avatarUrl'],
                    sexo: _formdata['sexo'],
                    celular: _formdata['celular'],
                    endereco: _formdata['endereco'],
                    numero: _formdata['numero'],
                    bairro: _formdata['bairro'],
                    cep: _formdata['cep'],
                    cidade: _formdata['cidade'],
                    uf: _formdata['uf'],
                    senha: _formdata['senha'],
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Nome'),
                            style: TextStyle(fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nome invalido';
                              }

                              if (value.trim().length <= 3) {
                                return 'Nome muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['nome'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Senha'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Senha invalido';
                              }

                              if (value.trim().length <= 3) {
                                return 'Senha muito pequeno.';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['senha'] = value,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Data Nasc.:   '
                                  '${formatDate(_data, [
                                dd,
                                '/',
                                mm,
                                '/',
                                yyyy
                              ])}',
                            ),
                            style: TextStyle(fontSize: 18),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              final value = await showDatePicker(
                                  context: context,
                                  initialDate: new DateTime.now(),
                                  firstDate: new DateTime(1900),
                                  lastDate: new DateTime(2100));

                              if (value != null && value != _data) {
                                setState(() {
                                  _data = value;

                                  _dateConvert =
                                      "${_data.day.toString()}/${_data.month.toString().padLeft(2, '0')}/${_data.year.toString().padLeft(4, '0')}";
                                  print("data nasc:" + _dateConvert);
                                });
                              }
                            },
                            onSaved: (value) =>
                                _formdata['datanasc'] = _dateConvert,
                          ),
                          /* DateTimeField(
                            format: format,
                            decoration:
                                InputDecoration(hintText: 'Data Nasc.:'),
                            style: TextStyle(fontSize: 18),
                            onShowPicker: (context, currentValue) async {
                              final value = await showDatePicker(
                                context: context,
                                initialDate: currentValue ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (value != null && value != _data) {
                                setState(() {
                                  _data = value;
                                });
                              }
                              return value;
                            },
                            validator: (value) =>
                                value == null ? 'Data Invalida' : null,
                            onSaved: (value) => _formdate[_vDate] = _data,
                          ), */
                          DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Sexo'),
                            style: TextStyle(fontSize: 18),
                            value: _sexo,
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _sexo = value;
                              });
                            },
                            items: _listSexo.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              );
                            }).toList(),
                            onSaved: (value) => _formdata['sexo'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'CPF'),
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
                            onSaved: (value) => _formdata['cpf'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'RG'),
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
                            onSaved: (value) => _formdata['rg'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'E-mail'),
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
                            onSaved: (value) => _formdata['email'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'CEP'),
                            style: TextStyle(fontSize: 20),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            onSaved: (value) => _formdata['cep'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Endereço'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.trim().length <= 30 ||
                                  value.trim().length >= 5) {
                                return 'Endereço inválido!';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['endereco'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Nº'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.trim().length <= 5 ||
                                  value.trim().length >= 1) {
                                return 'número inválido!';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['numero'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Bairro'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.trim().length <= 20 ||
                                  value.trim().length >= 5) {
                                return 'Bairro inválido!';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['bairro'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Cidade'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.trim().length <= 30 ||
                                  value.trim().length >= 3) {
                                return 'Cidade inválida!';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['cidade'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'UF'),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value.trim().length == 2) {
                                return 'UF inválida!';
                              }
                              return null;
                            },
                            onSaved: (value) => _formdata['uf'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Celular'),
                            style: TextStyle(fontSize: 20),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            onSaved: (value) => _formdata['celular'] = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            decoration: InputDecoration(labelText: 'Telefone'),
                            style: TextStyle(fontSize: 20),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            onSaved: (value) => _formdata['telefone'] = value,
                          ),
                        ],
                      )),
                ),
        ));
  }
}
