import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/core/network/network_info.dart';
import 'package:grupo_boticario/features/auth/data/datasource/user_data_source.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:grupo_boticario/features/auth/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.userDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> getUser(UserModel userModel) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userDataSource.getUser(userModel: userModel);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> setUser(UserModel userModel) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userDataSource.setUser(userModel: userModel);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
