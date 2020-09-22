import 'package:flutter/foundation.dart';
import 'package:grupo_boticario/core/error/exceptions.dart';
import 'package:grupo_boticario/features/microblogging/data/datasources/comentario_data_source.dart';
import 'package:grupo_boticario/features/microblogging/data/models/comentario_model.dart';
import 'package:grupo_boticario/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:grupo_boticario/features/microblogging/domain/repositories/comentario_repository.dart';

class ComentarioRepositoryImpl implements ComentarioRepository {
  final ComentarioDataSource comentarioDataSource;

  ComentarioRepositoryImpl({@required this.comentarioDataSource});
  @override
  Future<Either<Failure, List<ComentarioModel>>> getComentarios() async {
    try {
      final comentarios = await comentarioDataSource.getComentarios();

      return Right(comentarios);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ComentarioModel>>> setComentario(
      {ComentarioModel comentarioModel}) async {
    try {
      final comentarios =
          await comentarioDataSource.setComentario(comentario: comentarioModel);

      return Right(comentarios);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ComentarioModel>>> delComentario(
      {ComentarioModel comentarioModel}) async {
    try {
      final comentarios =
          await comentarioDataSource.delComentario(comentario: comentarioModel);

      return Right(comentarios);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
