import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
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

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio client;

  NumberTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getSpecifiedNumberTrivia(int number) async {
    return sendGetRequest(number);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return sendGetRequest(null);
  }

  Future<NumberTriviaModel> sendGetRequest(int? number) async {
    final endPoint = (number == null)
        ? '${ApiStrings.baseUrl}random'
        : '${ApiStrings.baseUrl}$number';
    debugPrint(endPoint);
    final response = await client.get(endPoint,
        options: Options(headers: {'Content-Type': 'application/json'}));
    debugPrint(response.toString());

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final NumberTriviaModel model =
        NumberTriviaModel.fromJson(jsonDecode(response.toString()));

    return model;
  }
}
