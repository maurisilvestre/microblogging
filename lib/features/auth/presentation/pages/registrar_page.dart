import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../bloc/auth/auth_bloc.dart';

class RegistrarPage extends StatefulWidget {
  final AuthBloc bloc;

  const RegistrarPage({Key key, @required this.bloc}) : super(key: key);
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _controller;
  final _controllerNome = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();
  final _controllerSenhaRepetir = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controllerNome.dispose();
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    _controllerSenhaRepetir.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar usuário'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).accentColor,
                    ),
                    title: TextFormField(
                      controller: _controllerNome,
                      key: Key('nome'),
                      validator: (String arg) {
                        if (arg.length < 3)
                          return 'O nome deve ter pelo menos 3 caracteres';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Nome'),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.email, color: Theme.of(context).accentColor),
                    title: TextFormField(
                      controller: _controllerEmail,
                      key: Key('email'),
                      validator: (String arg) {
                        if (arg.length == 0)
                          return 'O email é obrigatório';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Email'),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.lock, color: Theme.of(context).accentColor),
                    title: TextFormField(
                      obscureText: true,
                      controller: _controllerSenha,
                      key: Key('senha'),
                      validator: (String arg) {
                        if (arg.length < 6)
                          return 'A senha deve ter pelo menos 3 caracteres';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Senha'),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.lock, color: Theme.of(context).accentColor),
                    title: TextFormField(
                        obscureText: true,
                        controller: _controllerSenhaRepetir,
                        key: Key('senhaRepetir'),
                        validator: (String arg) {
                          if (arg.length < 6)
                            return 'A senha deve ter pelo menos 3 caracteres';
                          else if (_controllerSenhaRepetir.text !=
                              _controllerSenha.text)
                            return 'As senhas devem ser iguais';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Repetir Senha'),
                        onSaved: (String value) {}),
                  ),
                  Divider(),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        widget.bloc.add(AuthRegisterEmailPasswordEvent(
                            UserModel(
                                reference: null,
                                displayName: _controllerNome.text,
                                photoURL: null,
                                email: _controllerEmail.text),
                            _controllerEmail.text,
                            _controllerSenha.text));
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
