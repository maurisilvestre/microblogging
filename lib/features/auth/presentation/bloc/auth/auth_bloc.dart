import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/features/auth/domain/usecases/auth_register_email_password.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/auth_current_user.dart';
import '../../../domain/usecases/auth_email_password.dart';
import '../../../domain/usecases/auth_google.dart';
import '../../../domain/usecases/auth_log_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha do Servidor';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthEmailPassword getAuthEmailPassword;
  final AuthRegisterEmailPassword getAuthRegisterEmailPassword;
  final AuthGoogle getAuthGoogle;
  final AuthCurrentUser getCurrentUser;
  final AuthLogOut setLogOut;
  AuthBloc({
    @required AuthEmailPassword authEmailPassword,
    @required AuthRegisterEmailPassword authRegisterEmailPassword,
    @required AuthGoogle authGoogle,
    @required AuthCurrentUser currentUser,
    @required AuthLogOut logOut,
  })  : assert(authEmailPassword != null),
        assert(authRegisterEmailPassword != null),
        assert(authGoogle != null),
        assert(currentUser != null),
        assert(logOut != null),
        getAuthEmailPassword = authEmailPassword,
        getAuthRegisterEmailPassword = authRegisterEmailPassword,
        getAuthGoogle = authGoogle,
        getCurrentUser = currentUser,
        setLogOut = logOut,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthInitial) {
      yield Loading();
      final user = await getCurrentUser(NoParams());
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthCurrentUserEvent) {
      yield Loading();
      final user = await getCurrentUser(NoParams());
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthEmailPasswordEvent) {
      yield Loading();
      final user = await getAuthEmailPassword(Params(
          userModel: event.userModel,
          email: event.email,
          password: event.password));
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthRegisterEmailPasswordEvent) {
      yield Loading();
      final user = await getAuthRegisterEmailPassword(ParamsRegister(
          userModel: event.userModel,
          email: event.email,
          password: event.password));
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthGoogleEvent) {
      yield Loading();
      final user = await getAuthGoogle(NoParams());
      yield* _eitherLoadedOrErrorState(user);
    } else if (event is AuthLogOutEvent) {
      yield Loading();
      final user = await setLogOut(NoParams());

      yield* _eitherLoadedOrErrorState(user);
      yield Empty();
    }
  }

  Stream<AuthState> _eitherLoadedOrErrorState(
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
