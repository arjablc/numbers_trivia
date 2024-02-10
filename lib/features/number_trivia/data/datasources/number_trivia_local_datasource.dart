import '../models/trivia_model.dart';

abstract class NumberTriviaLocalDataSouce {
  ///This will get the locally cached Number trivia
  ///when no Internet connection is peresnt
  ///
  ///throws a [LocalException] if failed to do so.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// this will cache the number trivia
  ///
  /// thows a [LocalException] if failed to do so.
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia);
}
