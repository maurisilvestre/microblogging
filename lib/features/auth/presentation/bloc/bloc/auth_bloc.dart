import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/core/usecases/usecase.dart';
import 'package:grupo_boticario/features/auth/domain/usecases/auth_google.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha do Servidor';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthEmailPassword getAuthEmailPassword;
  final AuthGoogle getAuthGoogle;
  AuthBloc({
    @required AuthEmailPassword authEmailPassword,
    @required AuthGoogle authGoogle,
  })  : assert(authEmailPassword != null),
        assert(authGoogle != null),
        getAuthEmailPassword = authEmailPassword,
        getAuthGoogle = authGoogle,
        super(Empty());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthState) {
    } else if (event is AuthEmailPasswordEvent) {
      yield Loading();
      final user = await getAuthEmailPassword(
          Params(email: event.email, password: event.password));
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthEmailPasswordEvent) yield Loading();
    final user = await getAuthGoogle(NoParams());
    yield* _eitherLoadedOrErrorState(user);
    {}
  }

  Stream<AuthState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrNews,
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
