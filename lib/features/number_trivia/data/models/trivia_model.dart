import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required super.number, required super.text})
      : super();

  factory NumberTriviaModel.fromJson(Map<String, dynamic> map) {
    return NumberTriviaModel(
        number: (map['number'] as num).toInt(), text: map['text']);
  }
  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
