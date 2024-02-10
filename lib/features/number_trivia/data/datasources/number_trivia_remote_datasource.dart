import '../models/trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// calls the server on numbersapi.com/${number}?json
  ///
  /// Throws a [ServerException] for all errorcodes
  Future<NumberTriviaModel> getSpecifiedNumberTrivia(int number);

  /// calls the server on http://numbersapi.com/random/trivia?json?json
  ///
  /// Throws a [ServerException] for all errorcodes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
