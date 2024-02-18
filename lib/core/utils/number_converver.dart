import 'package:dartz/dartz.dart' show Either, Left, Right;

import '../errors/failure.dart';

class NumberUtil {
  Either<Failure, int> convertToNumber(String numString) {
    try {
      final number = int.parse(numString);
      if (number < 0) throw const FormatException();
      return Right(number);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
