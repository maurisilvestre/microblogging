import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comentario_model.dart';
import '../repositories/comentario_repository.dart';

class SetComentario implements UseCase<List<ComentarioModel>, Params> {
  final ComentarioRepository repository;

  SetComentario(this.repository);

  @override
  Future<Either<Failure, List<ComentarioModel>>> call(Params params) async {
    return await repository.setComentario(
        comentarioModel: params.comentarioModel);
  }
}

class Params extends Equatable {
  final ComentarioModel comentarioModel;

  Params({@required this.comentarioModel});

  @override
  List<Object> get props => [comentarioModel];
}
