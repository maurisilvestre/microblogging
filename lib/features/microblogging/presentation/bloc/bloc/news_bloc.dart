import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/usecases/usecase.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:grupo_boticario/features/microblogging/domain/usecases/get_news.dart';

part 'news_event.dart';
part 'news_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha do Servidor';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  NewsBloc({@required GetNews news})
      : assert(news != null),
        getNews = news,
        super(Empty());

  NewsState get initialState => Empty();

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNews) {
      yield Loading();
      final failureOrNews = await getNews(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrNews);
    }
  }

  Stream<NewsState> _eitherLoadedOrErrorState(
    Either<Failure, List<News>> failureOrNews,
  ) async* {
    yield failureOrNews.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (news) => Loaded(news: news),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return 'Erro inesperado';
    }
  }
}
