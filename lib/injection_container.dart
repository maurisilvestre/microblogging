import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/auth/data/datasource/auth_data_source.dart';
import 'features/auth/data/datasource/user_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repositories.dart';
import 'features/auth/domain/repositories/user_repositories.dart';
import 'features/auth/domain/usecases/auth_current_user.dart';
import 'features/auth/domain/usecases/auth_email_password.dart';
import 'features/auth/domain/usecases/auth_google.dart';
import 'features/auth/domain/usecases/auth_log_out.dart';
import 'features/auth/domain/usecases/auth_register_email_password.dart';
import 'features/auth/domain/usecases/user_get_user.dart';
import 'features/auth/domain/usecases/user_set_user.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/user/user_bloc.dart';
import 'features/microblogging/data/datasources/comentario_data_source.dart';
import 'features/microblogging/data/datasources/news_remote_data_source.dart';
import 'features/microblogging/data/repositories/comentario_repository_impl.dart';
import 'features/microblogging/data/repositories/news_repository_impl.dart';
import 'features/microblogging/domain/repositories/comentario_repository.dart';
import 'features/microblogging/domain/repositories/news_repository.dart';
import 'features/microblogging/domain/usecases/del_comentario.dart';
import 'features/microblogging/domain/usecases/get_comentario.dart';
import 'features/microblogging/domain/usecases/get_news.dart';
import 'features/microblogging/domain/usecases/set_comentario.dart';
import 'features/microblogging/presentation/bloc/comentario/comentario_bloc.dart';
import 'features/microblogging/presentation/bloc/news/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //Bloc
  sl.registerLazySingleton(() => NewsBloc(news: sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      authRegisterEmailPassword: sl(),
      authEmailPassword: sl(),
      authGoogle: sl(),
      currentUser: sl(),
      logOut: sl(),
    ),
  );
  sl.registerLazySingleton(
      () => UserBloc(userGetUser: sl(), userSetUser: sl()));
  sl.registerLazySingleton(() => ComentarioBloc(
      comentariosGet: sl(), comentarioSet: sl(), comentarioDel: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => AuthEmailPassword(sl()));
  sl.registerLazySingleton(() => AuthRegisterEmailPassword(sl()));
  sl.registerLazySingleton(() => AuthGoogle(sl()));
  sl.registerLazySingleton(() => AuthCurrentUser(sl()));
  sl.registerLazySingleton(() => AuthLogOut(sl()));
  sl.registerLazySingleton(() => UserGetUser(sl()));
  sl.registerLazySingleton(() => UserSetUser(sl()));
  sl.registerLazySingleton(() => GetComentarios(sl()));
  sl.registerLazySingleton(() => SetComentario(sl()));
  sl.registerLazySingleton(() => DelComentario(sl()));

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

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ComentarioRepository>(
    () => ComentarioRepositoryImpl(comentarioDataSource: sl()),
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

  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());
  sl.registerLazySingleton<ComentarioDataSource>(
      () => ComentarioDataSourceImpl());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
}
