import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/microblogging/data/datasources/news_remote_data_source.dart';
import 'features/microblogging/data/repositories/news_repository_impl.dart';
import 'features/microblogging/domain/repositories/news_repository.dart';
import 'features/microblogging/domain/usecases/get_news.dart';
import 'features/microblogging/presentation/bloc/bloc/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Microblogging
  //Bloc
  sl.registerFactory(() => NewsBloc(news: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );

  //! Core

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
