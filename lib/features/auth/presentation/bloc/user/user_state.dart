part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class Empty extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  final UserModel user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends UserState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
