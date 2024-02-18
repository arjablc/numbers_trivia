import '../../constants/api_constants.dart';
import 'package:dio/dio.dart';

class RemoteClient {
  BaseOptions options = BaseOptions(
    baseUrl: ApiStrings.baseUrl,
    contentType: 'application/json',
  );
}
