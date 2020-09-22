part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Empty extends AuthState {}

class Loading extends AuthState {}

class Loaded extends AuthState {
  final UserModel user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends AuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
