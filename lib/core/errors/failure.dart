import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

// Some general Faliures
class ServerFailure extends Failure {}

class LocalFailure extends Failure {}

class InvalidInputFailure extends Failure {}
