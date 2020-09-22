part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetUserEvent extends UserEvent {
  final UserModel userModel;

  UserGetUserEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class UserSetUserEvent extends UserEvent {
  final UserModel userModel;

  UserSetUserEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}
