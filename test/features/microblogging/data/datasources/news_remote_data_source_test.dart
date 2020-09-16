import 'dart:convert';

import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/features/microblogging/data/datasources/news_remote_data_source.dart';
import 'package:grupo_boticario/features/microblogging/data/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NewsRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NewsRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('news_response.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getNews', () {
    final tNews = [
      NewsModel.fromJson(json.decode(fixture('news_response.json'))['news'][0])
    ];
    test('deve realizar uma requisição GET', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getNews();
      // assert
      verify(mockHttpClient.get(
        'https://gb-mobile-app-teste.s3.amazonaws.com/data.json',
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test(
      'deve retornar novidades quando o response code for 200',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getNews();
        // assert
        expect(result, equals(tNews));
      },
    );

    test(
      'deve retornar um ServerException quando o response code for 404 ou outro',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getNews;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
