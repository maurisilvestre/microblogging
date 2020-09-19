part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  AuthEmailPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthGoogleEvent extends AuthEvent {}
