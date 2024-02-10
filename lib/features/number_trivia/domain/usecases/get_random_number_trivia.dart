import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecaase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParam> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call({required NoParam param}) {
    return repository.getRandomTrivia();
  }
}
