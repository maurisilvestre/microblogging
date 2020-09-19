import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/network/network_info.dart';
import 'package:grupo_boticario/features/microblogging/data/datasources/news_remote_data_source.dart';
import 'package:grupo_boticario/features/microblogging/data/models/message_model.dart';
import 'package:grupo_boticario/features/microblogging/data/models/news_model.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:grupo_boticario/features/microblogging/data/repositories/news_repository_impl.dart';

class MockRemoteDataSource extends Mock implements NewsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NewsRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NewsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('dispositivo está online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('dispositivo está offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getNews', () {
    final user = UserModel.fromJson({
      'name': 'O Boticário',
      'profile_picture':
          'https://pbs.twimg.com/profile_images/1240676323913347074/Gg09hEPx_400x400.jpg'
    });

    final message = MessageModel.fromJson({
      'content':
          'Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?',
      'created_at': '2020-02-02T16:10:33Z'
    });

    final tNewsModel = [
      NewsModel(
        user: user,
        message: message,
      )
    ];

    test('deve checar se o dispositivo está online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getNews();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'deve retornar as novidade do servidor quando a chamada remota do data source for um sucesso',
        () async {
          // arrange
          when(mockRemoteDataSource.getNews())
              .thenAnswer((_) async => tNewsModel);
          // act
          final result = await repository.getNews();
          // assert
          verify(mockRemoteDataSource.getNews());
          expect(result, equals(Right(tNewsModel)));
        },
      );

      // test(
      //   'should cache the data locally when the call to remote data source is successful',
      //   () async {
      //     // arrange
      //     when(mockRemoteDataSource.getRandomNumberTrivia())
      //         .thenAnswer((_) async => tNumberTriviaModel);
      //     // act
      //     await repository.getRandomNumberTrivia();
      //     // assert
      //     verify(mockRemoteDataSource.getRandomNumberTrivia());
      //     verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivia));
      //   },
      // );

      test(
        'deve retornar falha de servidor quando a chamada ao data source remoto não tiver sucesso',
        () async {
          // arrange
          when(mockRemoteDataSource.getNews()).thenThrow(ServerException());
          // act
          final result = await repository.getNews();
          // assert
          verify(mockRemoteDataSource.getNews());
          // verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    //   runTestsOffline(() {
    //   test(

    //     'should return last locally cached data when the cached data is present',
    //     () async {
    //       // arrange
    //       when(mockLocalDataSource.getLastNumberTrivia())
    //           .thenAnswer((_) async => tNumberTriviaModel);
    //       // act
    //       final result = await repository.getRandomNumberTrivia();
    //       // assert
    //       verifyZeroInteractions(mockRemoteDataSource);
    //       verify(mockLocalDataSource.getLastNumberTrivia());
    //       expect(result, equals(Right(tNumberTrivia)));
    //     },
    //   );

    //   test(
    //     'should return CacheFailure when there is no cached data present',
    //     () async {
    //       // arrange
    //       when(mockLocalDataSource.getLastNumberTrivia())
    //           .thenThrow(CacheException());
    //       // act
    //       final result = await repository.getRandomNumberTrivia();
    //       // assert
    //       verifyZeroInteractions(mockRemoteDataSource);
    //       verify(mockLocalDataSource.getLastNumberTrivia());
    //       expect(result, equals(Left(CacheFailure())));
    //     },
    //   );
    // });
  });
}
