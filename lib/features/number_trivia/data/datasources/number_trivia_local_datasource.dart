import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/local/hive.dart';
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

const boxName = "NUMBER_TRIVIA";
const key = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDataSouceImpl implements NumberTriviaLocalDataSouce {
  final HiveHelper hive;

  NumberTriviaLocalDataSouceImpl({required this.hive});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final hiveBox = await hive.openHiveBox(boxName);
    final result = await hiveBox.get(key);
    if (result == null) {
      throw LocalException(errorMessage: 'no data available');
    }

    return NumberTriviaModel.fromJson(jsonDecode(result));
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia) async {
    final hiveBox = await hive.openHiveBox(boxName);
    await hiveBox.put(key, jsonEncode(numberTrivia.toJson()));
  }
}
