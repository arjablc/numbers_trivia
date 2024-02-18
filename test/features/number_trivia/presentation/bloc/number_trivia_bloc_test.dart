import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/core/constants/app_strings.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/utils/number_converver.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_specified_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateNiceMocks([
  MockSpec<NumberUtil>(),
  MockSpec<GetSpecifiedNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>()
])
import './number_trivia_bloc_test.mocks.dart';

void main() {
  late MockGetRandomNumberTrivia getRandom;
  late MockGetSpecifiedNumberTrivia getSpecified;
  late MockNumberUtil util;
  late NumberTriviaBloc bloc;

  setUpAll(() {
    getRandom = MockGetRandomNumberTrivia();
    getSpecified = MockGetSpecifiedNumberTrivia();
    util = MockNumberUtil();
    bloc = NumberTriviaBloc(
        util: util, random: getRandom, specified: getSpecified);
  });

  group('NumberTrivia bloc', () {
    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'has the state of [NumberTriviaInitial] state when nothing is added',
        build: () => bloc,
        verify: (bloc) => bloc.state == NumberTriviaInitial());
  });

  group('get specified number trivia bloc test', () {
    const tNumber = '42';
    final tParsed = int.parse(tNumber);
    final NumberTrivia tTrivia =
        NumberTrivia(text: 'some test text', number: tParsed);
    void validInput() {
      return when(util.convertToNumber(any)).thenReturn(Right(tParsed));
    }

    void invalidInput() {
      return when(util.convertToNumber(any))
          .thenReturn(Left(InvalidInputFailure()));
    }

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'the util.convertToNumber method is called',
      setUp: () {
        validInput();
        when(getSpecified.call(param: anyNamed('param')))
            .thenAnswer((realInvocation) async => Right(tTrivia));
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) =>
          bloc.add(const GetSpecifiedNumberTriviaEvent(input: tNumber)),
      verify: (_) {
        verify(util.convertToNumber(tNumber));
      },
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit the error state when there is invalid input',
      setUp: () => invalidInput(),
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) =>
          bloc.add(const GetSpecifiedNumberTriviaEvent(input: tNumber)),
      expect: () => <NumberTriviaState>[
        const NumberTriviaErrorState(
            message: AppString.invalidInputFailureMessage)
      ],
    );

    void successfulUsecase() {
      return when(getSpecified.call(param: anyNamed('param')))
          .thenAnswer((_) async => Right(tTrivia));
    }

    void failedUsecase(bool isServer) {
      return when(getSpecified.call(param: anyNamed('param'))).thenAnswer(
          (_) async => Left(isServer ? ServerFailure() : LocalFailure()));
    }

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the getspecified usecase with a valid param and return a NumberTrivia in case of success ',
      setUp: () {
        validInput();
        successfulUsecase();
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) =>
          bloc.add(const GetSpecifiedNumberTriviaEvent(input: tNumber)),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        NumberTriviaLoadedState(trivia: tTrivia)
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the getspecified usecase with a valid param and return a error sate in case of failure with app. message ',
      setUp: () {
        validInput();
        failedUsecase(true);
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) =>
          bloc.add(const GetSpecifiedNumberTriviaEvent(input: tNumber)),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: AppString.serverFailureMessage)
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return the NumberTriviaErrorState with the cache/local exception message',
      setUp: () {
        validInput();
        failedUsecase(false);
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) =>
          bloc.add(const GetSpecifiedNumberTriviaEvent(input: tNumber)),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: AppString.cacheFailureMessage)
      ],
    );
  });

  group('get random number trivia bloc test', () {
    const NumberTrivia tTrivia =
        NumberTrivia(text: 'some test text', number: 42);

    void successfulUsecase() {
      return when(getRandom.call(param: anyNamed('param')))
          .thenAnswer((_) async => const Right(tTrivia));
    }

    void failedUsecase(bool isServer) {
      return when(getRandom.call(param: anyNamed('param'))).thenAnswer(
          (_) async => Left(isServer ? ServerFailure() : LocalFailure()));
    }

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the get random usecase with a valid param and return a NumberTrivia in case of success ',
      setUp: () {
        successfulUsecase();
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        const NumberTriviaLoadedState(trivia: tTrivia)
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should call the getspecified usecase with a valid param and return a error sate in case of failure with app. message ',
      setUp: () {
        failedUsecase(true);
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: AppString.serverFailureMessage)
      ],
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return the NumberTriviaErrorState with the cache/local exception message',
      setUp: () {
        failedUsecase(false);
      },
      build: () => NumberTriviaBloc(
          util: util, random: getRandom, specified: getSpecified),
      act: (bloc) => bloc.add(GetRandomNumberTriviaEvent()),
      expect: () => <NumberTriviaState>[
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: AppString.cacheFailureMessage)
      ],
    );
  });
}
