import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grupo_boticario/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:grupo_boticario/features/auth/presentation/widgets/google_auth.dart';
import 'package:grupo_boticario/features/microblogging/presentation/pages/news_page.dart';

import '../../../../injection_container.dart';

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
                  // return Container();
                  if (state is Empty) {
                    return GoogleAuth();
                    // return MessageDisplay(
                    //   message: 'Iniciando busca!',
                    // );
                  } else if (state is Loading) {
                    return Center(
                      child: Text('loading'),
                    );
                    // return LoadingWidget();
                  } else if (state is Loaded) {
                    return NewsPage();
                    // return NewsDisplay(news: state.news);
                  } else if (state is Error) {
                    // return MessageDisplay(
                    //   message: state.message,
                    // );
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
