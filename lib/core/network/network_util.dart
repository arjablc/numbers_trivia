import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkUtil {
  Future<bool> isConnected();
}

class NetwrokUtilImpl implements NetworkUtil {
  final InternetConnection _internetConnection;

  NetwrokUtilImpl({required InternetConnection internetConnection})
      : _internetConnection = internetConnection;

  @override
  Future<bool> isConnected() => _internetConnection.hasInternetAccess;
}
