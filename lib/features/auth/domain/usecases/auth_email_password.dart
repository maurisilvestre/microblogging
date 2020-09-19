import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repositories.dart';

class AuthEmailPassword implements UseCase<User, Params> {
  final AuthRepository repository;

  AuthEmailPassword(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.authEmailPassword(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
