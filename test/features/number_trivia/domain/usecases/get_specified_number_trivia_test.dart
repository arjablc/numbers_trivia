import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_specified_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import './get_specified_number_trivia_test.mocks.dart';

void main() {
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(
    text: 'test text',
    number: tNumber,
  );

  late MockNumberTriviaRepository tRepository;
  late GetSpecifiedNumberTrivia tUsecase;
  setUp(() {
    tRepository = MockNumberTriviaRepository();
    tUsecase = GetSpecifiedNumberTrivia(repository: tRepository);
  });
  test('should return the Number trivia for the number from repository',
      () async {
    when(tRepository.getSpecifiedTrivia(1))
        .thenAnswer((nothing) async => const Right(tNumberTrivia));

    final result = await tUsecase(param: const Param(number: 1));

    expect(result, const Right(tNumberTrivia));
  });
}
