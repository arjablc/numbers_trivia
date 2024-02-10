import 'package:equatable/equatable.dart';

enum Type { trivia, math }

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  const NumberTrivia({
    required this.text,
    required this.number,
  });

  @override
  List<Object?> get props => [
        text,
        number,
      ];
}
