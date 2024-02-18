import 'package:clean_architecture/core/network/network_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<InternetConnection>()])
import './network_util_impl_test.mocks.dart';

void main() {
  late MockInternetConnection internetConnection;
  late NetwrokUtilImpl networkUtil;
  setUp(() {
    internetConnection = MockInternetConnection();
    networkUtil = NetwrokUtilImpl(internetConnection: internetConnection);
  });
  group('Network Util Implementation', () {
    final tHasConnection = Future.value(true);
    test('should call the InternetConnection.hasInternet()', () {
      when(internetConnection.hasInternetAccess)
          .thenAnswer((realInvocation) => tHasConnection);

      final result = networkUtil.isConnected();

      verify(internetConnection.hasInternetAccess);
      expect(result, tHasConnection);
    });
  });
}
