import 'package:grupo_boticario/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:grupo_boticario/core/usecases/usecase.dart';
import 'package:grupo_boticario/features/microblogging/domain/entities/news.dart';
import 'package:grupo_boticario/features/microblogging/domain/repositories/news_repository.dart';

class GetNews implements UseCase<List<News>, NoParams> {
  final NewsRepository repository;

  GetNews(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await repository.getNews();
  }
}
