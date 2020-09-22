part of 'comentario_bloc.dart';

abstract class ComentarioState extends Equatable {
  const ComentarioState();

  @override
  List<Object> get props => [];
}

class ComentarioInitial extends ComentarioState {}

class Empty extends ComentarioState {}

class Loading extends ComentarioState {}

class Loaded extends ComentarioState {
  final List<ComentarioModel> comentarioModel;

  Loaded({@required this.comentarioModel});

  @override
  List<Object> get props => [comentarioModel];
}

class Error extends ComentarioState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
