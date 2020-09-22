import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/features/auth/data/models/user_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repositories.dart';

class AuthLogOut implements UseCase<void, NoParams> {
  final AuthRepository repository;

  AuthLogOut(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.authLogOut();
  }
}
