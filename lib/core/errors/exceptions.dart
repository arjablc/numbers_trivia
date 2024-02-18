class ServerException implements Exception {}

class LocalException implements Exception {
  final String errorMessage;

  LocalException({required this.errorMessage});
}
