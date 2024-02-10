import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

// Some general Faliures
class ServerFailure extends Failure {}

class LocalFailure extends Failure {}
