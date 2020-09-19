import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/auth/data/datasource/auth_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repositories.dart';
import 'features/auth/domain/usecases/auth_email_password.dart';
import 'features/auth/domain/usecases/auth_google.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';
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
  sl.registerFactory(() => AuthBloc(authEmailPassword: sl(), authGoogle: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => AuthEmailPassword(sl()));
  sl.registerLazySingleton(() => AuthGoogle(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      auth: sl(),
      googleSignIn: sl(),
      // user: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  // sl.registerLazySingleton(() => FirebaseUser);
}
