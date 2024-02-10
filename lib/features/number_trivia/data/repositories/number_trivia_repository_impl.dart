import 'dart:ui';

import '../../../../core/errors/exceptions.dart';

import '../../../../core/platform/network_util.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';
import '../models/trivia_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repo.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSouce localDataSouce;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkUtil networkUtil;

  NumberTriviaRepositoryImpl(
      {required this.localDataSouce,
      required this.remoteDataSource,
      required this.networkUtil});

  @override
  Future<Either<Failure, NumberTrivia>> getRandomTrivia() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getSpecifiedTrivia(int number) async {
    if (await networkUtil.isConnected()) {
      try {
        final NumberTriviaModel numberTrivia =
            await remoteDataSource.getSpecifiedNumberTrivia(number);

        localDataSouce.cacheNumberTrivia(numberTrivia);

        return Right(numberTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSouce.getLastNumberTrivia());
      } on LocalException {
        return Left(LocalFailure());
      }
    }
  }
}
