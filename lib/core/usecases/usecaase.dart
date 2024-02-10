import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call({required Param param});
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
