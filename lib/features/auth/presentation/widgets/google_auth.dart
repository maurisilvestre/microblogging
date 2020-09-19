import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupo_boticario/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(AuthGoogleEvent());
          },
          child: Text('Google')),
    );
  }
}
