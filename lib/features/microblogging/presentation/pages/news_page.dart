import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc/news_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/news_display.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novidades'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NewsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>(),
      child: Center(
        child: Column(
          children: <Widget>[
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is Empty) {
                  // BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
                  return MessageDisplay(
                    message: 'Iniciando busca!',
                  );
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return NewsDisplay(news: state.news);
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.message,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
