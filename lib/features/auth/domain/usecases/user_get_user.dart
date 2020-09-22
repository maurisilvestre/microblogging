import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';
import '../repositories/user_repositories.dart';

class UserGetUser implements UseCase<User, Params> {
  final UserRepository repository;

  UserGetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.getUser(params.userModel);
  }
}

class Params extends Equatable {
  final UserModel userModel;

  Params({@required this.userModel});

  @override
  List<Object> get props => [userModel];
}
