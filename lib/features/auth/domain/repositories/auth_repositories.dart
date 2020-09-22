import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> authEmailPassword(
      UserModel userModel, String email, String password);
  Future<Either<Failure, UserModel>> authRegisterEmailPassword(
      UserModel userModel, String email, String password);
  Future<Either<Failure, UserModel>> authGoogle();

  Future<Either<Failure, UserModel>> authCurrentUser();
  Future<Either<Failure, UserModel>> authLogOut();
}
