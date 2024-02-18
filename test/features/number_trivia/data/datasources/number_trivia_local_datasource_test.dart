import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/core/network/local/hive.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture/features/number_trivia/data/models/trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<Box>(), MockSpec<HiveHelper>()])
import './number_trivia_local_datasource_test.mocks.dart';

void main() {
  late MockHiveHelper hive;
  late MockBox box;
  late NumberTriviaLocalDataSouceImpl source;
  const NumberTriviaModel tModel =
      NumberTriviaModel(number: 42, text: 'some test text');

  setUpAll(() {
    hive = MockHiveHelper();
    box = MockBox();
    source = NumberTriviaLocalDataSouceImpl(hive: hive);
    when(hive.openHiveBox(any)).thenAnswer((_) async => box);
  });

  group('getLastNumberTrivia', () {
    test('should call the open box, get the NumberTriviaModel', () async {
      when(box.get(any))
          .thenAnswer((_) async => readFixture('locally_saved_trivia.json'));

      final result = await source.getLastNumberTrivia();

      verify(hive.openHiveBox('NUMBER_TRIVIA'));
      verify(box.get('CACHED_NUMBER_TRIVIA'));
      expect(result, tModel);
    });
    test('should throw a cache expection if no cached numberTrivia exits',
        () async {
      when(box.get(any)).thenAnswer((_) async => null);

      final call = source.getLastNumberTrivia;

      expect(() => call(), throwsA(const TypeMatcher<LocalException>()));
    });
  });

  group('cacheNumberTrivia', () {
    test('should call the hivebox.add and ', () async {
      when(box.add(any)).thenAnswer((_) async => 1);

      await source.cacheNumberTrivia(tModel);

      verify(hive.openHiveBox('NUMBER_TRIVIA'));
      verify(box.put('CACHED_NUMBER_TRIVIA', tModel));
    });
  });
}
