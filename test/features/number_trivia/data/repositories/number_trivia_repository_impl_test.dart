import 'package:clean_architecture/core/constants/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/network/network_util.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture/features/number_trivia/data/models/trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSouce>(),
  MockSpec<NetworkUtil>()
])
import './number_trivia_repository_impl_test.mocks.dart';

void main() {
  late NumberTriviaRepositoryImpl mockRepository;
  late MockNetworkUtil mockNetworkUtil;
  late MockNumberTriviaLocalDataSouce mockLoclDatasource;
  late MockNumberTriviaRemoteDataSource mockRemoteDatasource;

  setUp(() {
    mockNetworkUtil = MockNetworkUtil();
    mockLoclDatasource = MockNumberTriviaLocalDataSouce();
    mockRemoteDatasource = MockNumberTriviaRemoteDataSource();
    mockRepository = NumberTriviaRepositoryImpl(
        localDataSouce: mockLoclDatasource,
        remoteDataSource: mockRemoteDatasource,
        networkUtil: mockNetworkUtil);
  });
  void onlineTests(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkUtil.isConnected())
            .thenAnswer((realInvocation) => Future.value(true));
      });
      body();
    });
  }

  void offlineTests(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkUtil.isConnected())
            .thenAnswer((realInvocation) => Future.value(false));
      });
      body();
    });
  }

  group('get specified number trivia', () {
    const tNumber = 42;
    const tNumberTriviaModel =
        NumberTriviaModel(number: 42, text: 'some test text');
    const tNumberTrivia = tNumberTriviaModel;
    test('should call the network util and check for connection', () {
      when(mockNetworkUtil.isConnected())
          .thenAnswer((realInvocation) => Future.value(true));

      mockRepository.getSpecifiedTrivia(tNumber);

      verify(mockNetworkUtil.isConnected());
    });

    onlineTests(() {
      test('should return remote data when calling to remote datasources',
          () async {
        when(mockRemoteDatasource.getSpecifiedNumberTrivia(tNumber))
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        final result = await mockRepository.getSpecifiedTrivia(tNumber);

        expect(result, equals(const Right(tNumberTrivia)));
      });
      test('should cache the fetched trivia in local data source', () async {
        when(mockRemoteDatasource.getSpecifiedNumberTrivia(tNumber))
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        await mockRepository.getSpecifiedTrivia(tNumber);
        verify(mockRemoteDatasource.getSpecifiedNumberTrivia(tNumber));
        verify(mockLoclDatasource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('should not cache any trivia if an execption is thrown', () async {
        when(mockRemoteDatasource.getSpecifiedNumberTrivia(tNumber))
            .thenThrow(ServerException());
        final result = await mockRepository.getSpecifiedTrivia(tNumber);
        verify(mockRemoteDatasource.getSpecifiedNumberTrivia(tNumber));
        verifyZeroInteractions(mockLoclDatasource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });

    ///
    offlineTests(() {
      test('should fetch the local trivia when offline', () async {
        when(mockLoclDatasource.getLastNumberTrivia())
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        final result = await mockRepository.getSpecifiedTrivia(tNumber);

        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLoclDatasource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });
      test('should return a LocalException when no cache present', () async {
        when(mockLoclDatasource.getLastNumberTrivia())
            .thenThrow(LocalException(errorMessage: AppString.noDataFound));

        final result = await mockRepository.getSpecifiedTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLoclDatasource.getLastNumberTrivia());
        expect(result,
            equals(const Left(LocalFailure(message: AppString.noDataFound))));
      });
    });
  });

  group('get random Number trivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(number: 42, text: 'some test text');
    const tNumberTrivia = tNumberTriviaModel;
    test('should call the network util and check for connection', () {
      when(mockNetworkUtil.isConnected())
          .thenAnswer((realInvocation) => Future.value(true));

      mockRepository.getRandomTrivia();

      verify(mockNetworkUtil.isConnected());
    });
    onlineTests(() {
      test('should return remote data when calling to remote datasources',
          () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        final result = await mockRepository.getRandomTrivia();

        expect(result, equals(const Right(tNumberTrivia)));
      });
      test('should cache the fetched trivia in local data source', () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        await mockRepository.getRandomTrivia();
        verify(mockRemoteDatasource.getRandomNumberTrivia());
        verify(mockLoclDatasource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('should not cache any trivia if an execption is thrown', () async {
        when(mockRemoteDatasource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        final result = await mockRepository.getRandomTrivia();
        verify(mockRemoteDatasource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLoclDatasource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    offlineTests(() {
      test('should fetch the local trivia when offline', () async {
        when(mockLoclDatasource.getLastNumberTrivia())
            .thenAnswer((realInvocation) => Future.value(tNumberTriviaModel));
        final result = await mockRepository.getRandomTrivia();

        verifyNoMoreInteractions(mockRemoteDatasource);
        verify(mockLoclDatasource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });
      test('should return a LocalException when no cache present', () async {
        when(mockLoclDatasource.getLastNumberTrivia())
            .thenThrow(LocalException(errorMessage: AppString.noDataFound));

        final result = await mockRepository.getRandomTrivia();
        verifyNoMoreInteractions(mockRemoteDatasource);
        verify(mockLoclDatasource.getLastNumberTrivia());
        expect(result,
            equals(const Left(LocalFailure(message: AppString.noDataFound))));
      });
    });
  });
}
