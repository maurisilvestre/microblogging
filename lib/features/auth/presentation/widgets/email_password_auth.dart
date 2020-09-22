import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../pages/registrar_page.dart';

class EmailPasswordAuth extends StatelessWidget {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'E-mail',
                    ),
                    onChanged: (value) {
                      // inputStr = value;
                    },
                    onSubmitted: (_) {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              children: <Widget>[
                Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Senha',
                    ),
                    onChanged: (value) {
                      // inputStr = value;
                    },
                    onSubmitted: (_) {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            // alignment: Alignment.centerLeft,
            child: RaisedButton(
              // elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),

              color: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                authBloc.add(
                  AuthEmailPasswordEvent(
                      null, controllerEmail.text, controllerPassword.text),
                );
              },
              child: Text(
                'Entrar',
              ),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            // alignment: Alignment.centerLeft,
            child: FlatButton(
              // elevation: 0,
              shape: RoundedRectangleBorder(
                // side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
              ),

              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrarPage(
                      bloc: authBloc,
                    ),
                  ),
                );
              },
              child: Text('Registrar'),
            ),
          ),
        ],
      ),
    );
  }
}
