import 'package:clean_architecture/core/usecases/usecaase.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import './get_specified_number_trivia_test.mocks.dart';

void main() {
  const tNumberTrivia = NumberTrivia(
    text: 'test text',
    number: 12,
  );

  late MockNumberTriviaRepository tRepository;
  late GetRandomNumberTrivia tUsecase;
  setUp(() {
    tRepository = MockNumberTriviaRepository();
    tUsecase = GetRandomNumberTrivia(repository: tRepository);
  });
  test('should return the Number trivia from repository', () async {
    when(tRepository.getRandomTrivia())
        .thenAnswer((nothing) async => const Right(tNumberTrivia));

    final result = await tUsecase(param: NoParam());

    expect(result, const Right(tNumberTrivia));
  });
}
