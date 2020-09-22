import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../entities/user.dart';
import '../repositories/user_repositories.dart';

class UserSetUser implements UseCase<User, ParamsSet> {
  final UserRepository repository;

  UserSetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(ParamsSet params) async {
    return await repository.setUser(params.userModel);
  }
}

class ParamsSet extends Equatable {
  final UserModel userModel;

  ParamsSet({@required this.userModel});

  @override
  List<Object> get props => [userModel];
}
