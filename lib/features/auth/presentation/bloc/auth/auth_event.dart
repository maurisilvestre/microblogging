part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEmailPasswordEvent extends AuthEvent {
  final UserModel userModel;
  final String email;
  final String password;

  AuthEmailPasswordEvent(this.userModel, this.email, this.password);

  @override
  List<Object> get props => [userModel, email, password];
}

class AuthRegisterEmailPasswordEvent extends AuthEvent {
  final UserModel userModel;
  final String email;
  final String password;

  AuthRegisterEmailPasswordEvent(this.userModel, this.email, this.password);

  @override
  List<Object> get props => [userModel, email, password];
}

class AuthGoogleEvent extends AuthEvent {}

class AuthCurrentUserEvent extends AuthEvent {}

class AuthLogOutEvent extends AuthEvent {}
