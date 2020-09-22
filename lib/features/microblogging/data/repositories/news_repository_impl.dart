import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/network/network_info.dart';
import 'package:grupo_boticario/features/microblogging/data/datasources/news_remote_data_source.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:grupo_boticario/features/microblogging/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<News>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await remoteDataSource.getNews();

        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
