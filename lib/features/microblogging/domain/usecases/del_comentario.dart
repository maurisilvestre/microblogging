import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comentario_model.dart';
import '../repositories/comentario_repository.dart';

class DelComentario implements UseCase<List<ComentarioModel>, ParamsDel> {
  final ComentarioRepository repository;

  DelComentario(this.repository);

  @override
  Future<Either<Failure, List<ComentarioModel>>> call(ParamsDel params) async {
    return await repository.delComentario(
        comentarioModel: params.comentarioModel);
  }
}

class ParamsDel extends Equatable {
  final ComentarioModel comentarioModel;

  ParamsDel({@required this.comentarioModel});

  @override
  List<Object> get props => [comentarioModel];
}
