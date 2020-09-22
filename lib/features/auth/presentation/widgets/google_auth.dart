import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.6,
      // alignment: Alignment.centerLeft,
      child: RaisedButton.icon(
        // elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),

        icon: Image.asset(
          'images/glogo.png',
          height: 32,
        ),
        color: Colors.white,
        textColor: Colors.grey[600],
        onPressed: () async {
          BlocProvider.of<AuthBloc>(context).add(AuthGoogleEvent());
        },
        label: Text('Entrar usando o Google'),
      ),
    );
  }
}
