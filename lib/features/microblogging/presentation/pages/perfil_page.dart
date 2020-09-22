import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupo_boticario/features/auth/presentation/bloc/auth/auth_bloc.dart';

import '../../../../injection_container.dart';
import '../../../auth/data/models/user_model.dart';

class PerfilPage extends StatelessWidget {
  final UserModel userModel;

  const PerfilPage({Key key, @required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                userModel.photoURL == null
                    ? Icon(
                        Icons.person,
                        size: 48,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AdvancedNetworkImage(
                            userModel.photoURL,
                            useDiskCache: true,
                            cacheRule: CacheRule(
                              maxAge: const Duration(days: 90),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Nome: ',
                      ),
                      Container(
                        child: Text(
                          userModel.displayName == null
                              ? ''
                              : userModel.displayName,
                          style:
                              TextStyle(color: Theme.of(context).disabledColor),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Email: ',
                      ),
                      Container(
                        child: Text(
                          userModel.email,
                          style:
                              TextStyle(color: Theme.of(context).disabledColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Colors.red[700],
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
                  },
                  child: Text(
                    'Sair',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<AuthBloc> buildBodyNews(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is AuthInitial) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthCurrentUserEvent());
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Empty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AdvancedNetworkImage(
                                    state.user.photoURL,
                                    useDiskCache: true,
                                    cacheRule: CacheRule(
                                      maxAge: const Duration(days: 90),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      'Nome: ',
                                    ),
                                    Container(
                                      child: Text(
                                        state.user.displayName,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .disabledColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      'Email: ',
                                    ),
                                    Container(
                                      child: Text(
                                        state.user.email,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .disabledColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                color: Colors.red[700],
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(AuthLogOutEvent());
                                },
                                child: Text(
                                  'Sair',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is Error) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
