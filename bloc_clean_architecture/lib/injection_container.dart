import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import './core/platform/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './features/trivial/domain/repositories/trivia_repo.dart';
import 'features/trivial/data/repositories/trivia_repo_impl.dart';
import 'features/trivial/presentation/bloc/trivia_bloc_bloc.dart';
import 'features/trivial/data/data_sources/trivia_local_data_source.dart';
import './features/trivial/data/data_sources/trivia_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_random_trivia_use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_concrete_trivial_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  //Bloc
  sl.registerFactory(
    () => TriviaBloc(
      concreteTrivialUseCase: sl(),
      randomTrivialUseCase: sl(),
      inputConverter: sl(),
    ),
  );

// Use cases
  sl.registerLazySingleton(() => GetConcreteTrivialUseCase(sl()));
  sl.registerLazySingleton(() => GetRandomTrivialUseCase(sl()));

// Repository
  sl.registerLazySingleton<TriviaRepo>(
    () => TriviaRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

// Data sources
  sl.registerLazySingleton<TriviaRemoteDataSource>(
    () => TriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<TriviaLocalDataSource>(
    () => TriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
