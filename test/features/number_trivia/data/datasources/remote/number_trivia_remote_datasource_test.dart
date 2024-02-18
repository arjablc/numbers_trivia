import 'package:clean_architecture/core/constants/api_constants.dart';
import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture/features/number_trivia/data/models/trivia_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<Dio>()])
import './number_trivia_remote_datasource_test.mocks.dart';

void main() {
  const tNumber = 42;
  const tNumberTriviaModel =
      NumberTriviaModel(number: 42, text: 'some random text');
  late MockDio dio;
  late NumberTriviaRemoteDataSourceImpl datasource;

  setUpAll(() {
    dio = MockDio();
    datasource = NumberTriviaRemoteDataSourceImpl(client: dio);
  });
  void setupWithSucces() {
    when(dio.get(any,
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async => Response<String>(
            requestOptions: RequestOptions(),
            data: readFixture('normal_trivia.json'),
            statusCode: 200));
  }

  void setupWithFailure() {
    when(dio.get(any,
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((realInvocation) async => Response<String>(
            requestOptions: RequestOptions(),
            data: readFixture('normal_trivia.json'),
            statusCode: 400));
  }

  group('get specified number trivia', () {
    test('get the specified number trivia calling the dio.get method',
        () async {
      setupWithSucces();
      final result = await datasource.getSpecifiedNumberTrivia(tNumber);

      expect(result, tNumberTriviaModel);
    });
    test(
        'should throw a ServerExceptions for status codes other than starting from 200',
        () async {
      setupWithFailure();
      final call = datasource.getSpecifiedNumberTrivia;

      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get random Number trivia', () {
    test('should return NumberTriviaMode coming from dio.get method', () async {
      setupWithSucces();

      final result = await datasource.getRandomNumberTrivia();

      expect(result, tNumberTriviaModel);
    });
    test(
        'should throw a ServerExceptions for status codes other than starting from 200',
        () async {
      setupWithFailure();
      final call = datasource.getRandomNumberTrivia();

      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
