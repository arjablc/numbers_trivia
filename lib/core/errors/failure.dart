import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String? errorMessage;

  const Failure({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

// Some general Faliures
class ServerFailure extends Failure {
  const ServerFailure() : super(errorMessage: null);
}

class LocalFailure extends Failure {
  const LocalFailure({message}) : super(errorMessage: message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure() : super(errorMessage: null);
}
