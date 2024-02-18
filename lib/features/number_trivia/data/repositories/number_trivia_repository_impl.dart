import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_util.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repo.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';
import '../models/trivia_model.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSouce localDataSouce;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkUtil networkUtil;

  NumberTriviaRepositoryImpl(
      {required this.localDataSouce,
      required this.remoteDataSource,
      required this.networkUtil});

  @override
  Future<Either<Failure, NumberTrivia>> getRandomTrivia() async {
    return await getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getSpecifiedTrivia(int number) async {
    return await getTrivia(() {
      return remoteDataSource.getSpecifiedNumberTrivia(number);
    });
  }

  Future<Either<Failure, NumberTrivia>> getTrivia(
      Future<NumberTriviaModel> Function() function) async {
    if (await networkUtil.isConnected()) {
      try {
        final remoteTrivia = await function();
        localDataSouce.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSouce.getLastNumberTrivia();
        return Right(localTrivia);
      } on LocalException {
        return Left(LocalFailure());
      }
    }
  }
}
