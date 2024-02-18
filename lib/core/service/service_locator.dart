import '../network/local/hive.dart';
import '../network/network_util.dart';
import '../usecases/usecaase.dart';
import '../utils/number_converver.dart';
import '../../features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import '../../features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import '../../features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import '../../features/number_trivia/domain/repositories/number_trivia_repo.dart';
import '../../features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import '../../features/number_trivia/domain/usecases/get_specified_number_trivia.dart';
import '../../features/number_trivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

void init() {
  //bloc
  sl.registerFactory(
      () => NumberTriviaBloc(random: sl(), util: sl(), specified: sl()));

  //use cases
  sl.registerLazySingleton(() => GetRandomNumberTrivia(repository: sl()));
  sl.registerLazySingleton(() => GetSpecifiedNumberTrivia(repository: sl()));

  //repository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          localDataSouce: sl(), remoteDataSource: sl(), networkUtil: sl()));

  //data sources
  sl.registerLazySingleton<NumberTriviaLocalDataSouce>(
      () => NumberTriviaLocalDataSouceImpl(hive: sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  //external lib
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<HiveHelper>(() => HiveHelperImpl());
  sl.registerLazySingleton(() => InternetConnection());
  //core
  sl.registerLazySingleton(() => NumberUtil());
  sl.registerLazySingleton<NetworkUtil>(
      () => NetwrokUtilImpl(internetConnection: sl()));
}
