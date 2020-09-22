import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repositories.dart';

class AuthCurrentUser implements UseCase<UserModel, NoParams> {
  final AuthRepository repository;

  AuthCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.authCurrentUser();
  }
}
