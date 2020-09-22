part of 'comentario_bloc.dart';

abstract class ComentarioEvent extends Equatable {
  const ComentarioEvent();

  @override
  List<Object> get props => [];
}

class GetComentariosEvents extends ComentarioEvent {}

class SetComentarioEvents extends ComentarioEvent {
  final ComentarioModel comentarioModel;

  SetComentarioEvents(this.comentarioModel);

  @override
  List<Object> get props => [comentarioModel];
}

class DelComentarioEvents extends ComentarioEvent {
  final ComentarioModel comentarioModel;

  DelComentarioEvents(this.comentarioModel);

  @override
  List<Object> get props => [comentarioModel];
}
