import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';

import '../models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  /// Chama o endpoint https://gb-mobile-app-teste.s3.amazonaws.com/data.json.
  ///
  /// Gera um [ServerException] para todos os códigos de erro.
  Future<List<NewsModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<NewsModel>> getNews() async {
    final response = await client.get(
      'https://gb-mobile-app-teste.s3.amazonaws.com/data.json',
    );

    if (response.statusCode == 200) {
      List _news = json.decode(utf8.decode(response.bodyBytes))['news'];

      return _news.map((item) => NewsModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }
}
