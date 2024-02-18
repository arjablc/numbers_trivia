part of 'numbertrivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  @override
  List<Object> get props => [];
}

final class GetSpecifiedNumberTriviaEvent extends NumberTriviaEvent {
  final String input;

  const GetSpecifiedNumberTriviaEvent({required this.input});

  @override
  List<Object> get props => [input];
}

final class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
