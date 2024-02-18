import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/utils/number_converver.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NumberUtil util;
  int tNumber = 42;
  String tNumberString = '42';

  setUp(() {
    util = NumberUtil();
  });

  group('number utils', () {
    test('should return a int if the string is a int', () {
      final num = util.convertToNumber(tNumberString);

      expect(num, equals(Right(tNumber)));
    });
    test(
        'should return the InvalidInputFaliure if the numstring is not parsable',
        () {
      tNumberString = 'abc ';

      final result = util.convertToNumber(tNumberString);

      expect(result, equals(Left(InvalidInputFailure())));
    });
    test(
        'should return the invalid input faliure when provided a signed(negative) number',
        () {
      tNumberString = '-111';
      final result = util.convertToNumber(tNumberString);

      expect(result, equals(Left(InvalidInputFailure())));
    });
  });
}
