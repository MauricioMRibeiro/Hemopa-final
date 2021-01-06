import 'package:flutter/material.dart';
import 'package:hemopa_app/models/user.dart';
import 'package:hemopa_app/routes/app_routes.dart';
import 'package:hemopa_app/views/dados_usuario.dart';

class TelaHome extends StatelessWidget {

  final User user;
  const TelaHome({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HEMOPA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Perfil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DadosUsuario(user: user)))
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(2),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.insert_invitation_rounded,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Agendamento",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {
                Navigator.of(context).pushNamed(
                  AppRoutes.AGENDAMENTO_DOACAO,
                )
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Checkin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.history_outlined,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Histórico",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.description_rounded,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Comprovante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 70,
                ),
                Text(
                  "Cancelar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ]),
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
