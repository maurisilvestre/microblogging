import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/network/network_info.dart';
import 'package:grupo_boticario/features/auth/data/datasource/auth_data_source.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';
import 'package:grupo_boticario/features/auth/domain/entities/user.dart';
import 'package:grupo_boticario/features/auth/domain/repositories/auth_repositories.dart';

typedef Future<User> _EmailOrGoogle();

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.authDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, UserModel>> _auth(
    _EmailOrGoogle emailOrGoogle,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await emailOrGoogle();
        if (remoteAuth == null) Left(ServerFailure());

        return Right(remoteAuth);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> authEmailPassword(
      UserModel userModel, String email, String password) async {
    return await _auth(() => authDataSource.authEmailPassword(
        userModel: userModel, email: email, password: password));
  }

  Future<Either<Failure, UserModel>> authRegisterEmailPassword(
      UserModel userModel, String email, String password) async {
    return await _auth(() => authDataSource.authRegisterEmailPassword(
        userModel: userModel, email: email, password: password));
  }

  @override
  Future<Either<Failure, UserModel>> authGoogle() async {
    return await _auth(() => authDataSource.authGoogleSignIn());
  }

  @override
  Future<Either<Failure, UserModel>> authCurrentUser() async {
    return await _auth(() => authDataSource.authCurrentUser());
  }

  @override
  Future<Either<Failure, UserModel>> authLogOut() async {
    return await _auth(() => authDataSource.authLogOut());
  }
}
