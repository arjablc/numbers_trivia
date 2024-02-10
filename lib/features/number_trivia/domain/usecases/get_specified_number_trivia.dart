// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/core/usecases/usecaase.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';

class GetSpecifiedNumberTrivia implements UseCase<NumberTrivia, Param> {
  final NumberTriviaRepository repository;

  GetSpecifiedNumberTrivia({required this.repository});
  @override
  Future<Either<Failure, NumberTrivia>> call({required param}) async {
    return await repository.getSpecifiedTrivia(param.number);
  }
}

class Param extends Equatable {
  final int number;
  const Param({
    required this.number,
  });
  @override
  List<Object?> get props => [number];
}
