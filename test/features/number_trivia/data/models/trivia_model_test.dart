import 'dart:convert';

import 'package:clean_architecture/features/number_trivia/data/models/trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  NumberTriviaModel tNumberTriviaModel =
      const NumberTriviaModel(number: 42, text: "some random text");
  test("model should be an implementation of entitiy", () {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('from json', () {
    test("should create a valid model from the joson data with int number", () {
      Map<String, dynamic> jsonData =
          jsonDecode(readFixture('normal_trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonData);

      expect(result, tNumberTriviaModel);
    });
    test("should create a valid model from the joson data with double number",
        () {
      Map<String, dynamic> jsonData =
          jsonDecode(readFixture('normal_trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonData);

      expect(result, tNumberTriviaModel);
    });
  });
  group("to Json", () {
    test('should return a valid Map with appropriate data', () {
      final result = tNumberTriviaModel.toJson();

      final Map<String, dynamic> expectedMap = {
        'number': 42,
        'text': "some random text"
      };
      expect(result, expectedMap);
    });
  });
}
