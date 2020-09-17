import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/usecases/usecase.dart';
import 'package:grupo_boticario/features/microblogging/data/models/message_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/news_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/user_model.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/message.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/user.dart';
import 'package:grupo_boticario/features/microblogging/domain/usecases/get_news.dart';

import 'package:grupo_boticario/features/microblogging/presentation/bloc/bloc/news_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetNews extends Mock implements GetNews {}

void main() {
  NewsBloc bloc;
  MockGetNews mockGetNews;

  setUp(() {
    mockGetNews = MockGetNews();
    bloc = NewsBloc(news: mockGetNews);
  });

  test('initialState deve ser Empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('getNews', () {
    final tUser = UserModel(
      name: 'O Boticário',
      profilePicture:
          'https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg',
    );
    final tMessage = MessageModel(
        content:
            'Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?',
        createdAt: DateTime.parse("2020-02-02T16:10:33Z"));

    final tNews = [NewsModel(user: tUser, message: tMessage)];
    test(
      'deve buscar os dados do use case',
      () async {
        // arrange
        when(mockGetNews(any)).thenAnswer((_) async => Right(tNews));
        // act
        bloc.add(GetNewsEvent());
        await untilCalled(mockGetNews(any));
        // assert
        verify(mockGetNews(NoParams()));
      },
    );

    test(
      'deve aparecer [Loading, Loaded] quando a busca dos dados for com sucesso',
      () async {
        // arrange
        when(mockGetNews(any)).thenAnswer((_) async => Right(tNews));
        // assert later
        final expected = [
          // Empty(),
          Loading(),
          Loaded(news: tNews),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetNewsEvent());
      },
    );

    test(
      'deve aparecer [Loading, Error] quando falhar em buscar os dados',
      () async {
        // arrange
        when(mockGetNews(any)).thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          // Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetNewsEvent());
      },
    );
  });
}
