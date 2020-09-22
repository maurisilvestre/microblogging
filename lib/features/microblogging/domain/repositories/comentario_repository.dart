import 'package:dartz/dartz.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:grupo_boticario/features/microblogging/data/models/comentario_model.dart';

abstract class ComentarioRepository {
  Future<Either<Failure, List<ComentarioModel>>> getComentarios();
  Future<Either<Failure, List<ComentarioModel>>> setComentario(
      {ComentarioModel comentarioModel});
  Future<Either<Failure, List<ComentarioModel>>> delComentario(
      {ComentarioModel comentarioModel});
}
