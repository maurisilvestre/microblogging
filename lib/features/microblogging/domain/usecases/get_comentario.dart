import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comentario_model.dart';
import '../entities/comentario.dart';
import '../repositories/comentario_repository.dart';

class GetComentarios implements UseCase<List<Comentario>, NoParams> {
  final ComentarioRepository repository;

  GetComentarios(this.repository);

  @override
  Future<Either<Failure, List<ComentarioModel>>> call(NoParams params) async {
    return await repository.getComentarios();
  }
}
