import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../../data/models/comentario_model.dart';
import '../bloc/comentario/comentario_bloc.dart';

class ComentariosPage extends StatefulWidget {
  final UserModel userModel;

  const ComentariosPage({Key key, @required this.userModel}) : super(key: key);

  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        create: (context) => sl<ComentarioBloc>(),
        child: BlocBuilder<ComentarioBloc, ComentarioState>(
          builder: (context, state) {
            if (state is ComentarioInitial) {
              BlocProvider.of<ComentarioBloc>(context)
                  .add(GetComentariosEvents());
              return CircularProgressIndicator();
            } else if (state is Loading) {
              return CircularProgressIndicator();
            } else if (state is Loaded) {
              return ComentariosLista(
                comentarios: state.comentarioModel,
                userModel: widget.userModel,
              );
            }
            ;
          },
        ),
      ),
    );
  }
}

class ComentariosLista extends StatefulWidget {
  final List<ComentarioModel> comentarios;
  final UserModel userModel;

  const ComentariosLista({
    Key key,
    @required this.comentarios,
    @required this.userModel,
  }) : super(key: key);

  @override
  _ComentariosListaState createState() => _ComentariosListaState();
}

class _ComentariosListaState extends State<ComentariosLista> {
  TextEditingController _controllerComentario;

  @override
  void initState() {
    _controllerComentario = TextEditingController();
    initializeDateFormatting();
    super.initState();
  }

  @override
  void dispose() {
    _controllerComentario.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: widget.comentarios.length,
            itemBuilder: (context, index) {
              ComentarioModel _comentario = ComentarioModel(
                  reference: widget.comentarios[index].reference,
                  comentario: widget.comentarios[index].comentario,
                  userModel: UserModel(
                      reference: widget.comentarios[index].userModel.reference,
                      displayName:
                          widget.comentarios[index].userModel.displayName,
                      photoURL: widget.comentarios[index].userModel.photoURL,
                      email: widget.comentarios[index].userModel.email),
                  createdAt: widget.comentarios[index].createdAt);
              return Card(
                elevation: 0,
                child: Stack(
                  children: <Widget>[
                    ListTile(
                      leading: _comentario.userModel.photoURL == null
                          ? Icon(
                              Icons.person,
                              size: 48,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                fit: BoxFit.cover,
                                image: AdvancedNetworkImage(
                                  _comentario.userModel.photoURL,
                                  useDiskCache: true,
                                  cacheRule: CacheRule(
                                    maxAge: const Duration(days: 90),
                                  ),
                                ),
                              ),
                            ),
                      title: Text(
                        _comentario.comentario,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      subtitle: Text(
                        _comentario.userModel.displayName,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        if (_comentario.userModel.email ==
                            widget.userModel.email) {
                          final result = await showDialog(
                            context: context,
                            builder: (ctx) {
                              _controllerComentario.text =
                                  _comentario.comentario;
                              return SimpleDialog(
                                backgroundColor: Theme.of(context).primaryColor,
                                contentPadding: EdgeInsets.all(8),
                                children: <Widget>[
                                  Text(
                                    'Editar comentário',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                          color: Theme.of(context).accentColor),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _controllerComentario,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Colors.white,
                                        elevation: 0,
                                        onPressed: () {
                                          Navigator.of(context).pop(1);
                                        },
                                        child: Text(
                                          'Salvar',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      RaisedButton(
                                        color: Colors.red[700],
                                        elevation: 0,
                                        onPressed: () {
                                          Navigator.of(context).pop(2);
                                        },
                                        child: Text(
                                          'Deletar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                          switch (result) {
                            case 1:
                              BlocProvider.of<ComentarioBloc>(context).add(
                                SetComentarioEvents(
                                  ComentarioModel(
                                    reference: _comentario.reference,
                                    comentario: _controllerComentario.text,
                                    userModel: widget.userModel,
                                    createdAt: DateTime.now(),
                                  ),
                                ),
                              );

                              break;
                            case 2:
                              BlocProvider.of<ComentarioBloc>(context).add(
                                DelComentarioEvents(
                                  _comentario,
                                ),
                              );
                              break;
                            default:
                              _controllerComentario.clear();
                          }

                          _controllerComentario.clear();
                        }
                      },
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Text(
                        DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_BR')
                            .format(_comentario.createdAt),
                        style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),

            // color: Theme.of(context).cardColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: _controllerComentario,
                  decoration: InputDecoration(border: InputBorder.none),
                )),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      BlocProvider.of<ComentarioBloc>(context).add(
                        SetComentarioEvents(
                          ComentarioModel(
                            reference: null,
                            comentario: _controllerComentario.text,
                            userModel: widget.userModel,
                            createdAt: DateTime.now(),
                          ),
                        ),
                      );
                      _controllerComentario.clear();
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
