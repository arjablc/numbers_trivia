import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getSpecifiedTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomTrivia();
}
