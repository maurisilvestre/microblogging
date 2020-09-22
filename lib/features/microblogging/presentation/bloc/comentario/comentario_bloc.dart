import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/comentario_model.dart';
import '../../../domain/usecases/del_comentario.dart';
import '../../../domain/usecases/get_comentario.dart';
import '../../../domain/usecases/set_comentario.dart';

part 'comentario_event.dart';
part 'comentario_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Falha do Servidor';

class ComentarioBloc extends Bloc<ComentarioEvent, ComentarioState> {
  final GetComentarios getComentarios;
  final SetComentario setComentario;
  final DelComentario delComentario;

  ComentarioBloc({
    @required GetComentarios comentariosGet,
    @required SetComentario comentarioSet,
    @required DelComentario comentarioDel,
  })  : assert(comentariosGet != null),
        assert(comentarioSet != null),
        assert(comentarioDel != null),
        getComentarios = comentariosGet,
        setComentario = comentarioSet,
        delComentario = comentarioDel,
        super(ComentarioInitial());

  @override
  Stream<ComentarioState> mapEventToState(
    ComentarioEvent event,
  ) async* {
    if (event is GetComentariosEvents) {
      yield Loading();
      final comentarios = await getComentarios(NoParams());

      yield* _eitherLoadedOrErrorState(comentarios);
    }
    if (event is SetComentarioEvents) {
      yield Loading();
      final comentario =
          await setComentario(Params(comentarioModel: event.comentarioModel));

      yield* _eitherLoadedOrErrorState(comentario);
    }
    if (event is DelComentarioEvents) {
      yield Loading();
      final comentario = await delComentario(
          ParamsDel(comentarioModel: event.comentarioModel));

      yield* _eitherLoadedOrErrorState(comentario);
    }
  }

  Stream<ComentarioState> _eitherLoadedOrErrorState(
    Either<Failure, List<ComentarioModel>> failureOrNews,
  ) async* {
    yield failureOrNews.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (comentario) {
        return Loaded(comentarioModel: comentario);
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
