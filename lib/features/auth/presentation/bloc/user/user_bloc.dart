import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/features/auth/domain/usecases/user_set_user.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/usecases/user_get_user.dart';

part 'user_event.dart';
part 'user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha do Servidor';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserGetUser getUserGetUser;
  final UserSetUser setUserSetUser;
  UserBloc({
    @required UserGetUser userGetUser,
    @required UserSetUser userSetUser,
  })  : assert(userGetUser != null),
        assert(userSetUser != null),
        getUserGetUser = userGetUser,
        setUserSetUser = userSetUser,
        super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserGetUserEvent) {
      yield Loading();

      final user = await getUserGetUser(Params(userModel: event.userModel));
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is UserSetUserEvent) {
      yield Loading();

      final user = await setUserSetUser(ParamsSet(userModel: event.userModel));
      yield* _eitherLoadedOrErrorState(user);
    }
  }

  Stream<UserState> _eitherLoadedOrErrorState(
    Either<Failure, UserModel> failureOrNews,
  ) async* {
    yield failureOrNews.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (user) {
        return Loaded(user: user);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      default:
        return 'Erro inesperado';
    }
  }
}
