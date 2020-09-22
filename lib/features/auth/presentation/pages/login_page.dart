import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../microblogging/presentation/pages/news_page.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/email_password_auth.dart';
import '../widgets/google_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildBodyLogin(context),
      ),
    );
  }

  BlocProvider<AuthBloc> buildBodyLogin(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthCurrentUserEvent());
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RegisterLoaded) {
                    return LoginWidget();
                  } else if (state is Empty) {
                    return LoginWidget();
                  } else if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Loaded) {
                    return NewsPage(
                      userModel: state.user,
                    );
                  } else if (state is Error) {
                    return LoginWidget(
                      mensagem: state.message,
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

class LoginWidget extends StatelessWidget {
  final String mensagem;
  const LoginWidget({
    Key key,
    this.mensagem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'images/boti-amphora.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              EmailPasswordAuth(),
              GoogleAuth(),
            ],
          ),
        ),
      ),
    );
  }
}
