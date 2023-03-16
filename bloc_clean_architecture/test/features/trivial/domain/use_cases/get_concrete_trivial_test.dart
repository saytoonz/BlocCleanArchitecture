import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'get_random_trivial_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivia_repo.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_concrete_trivial_use_case.dart';

@GenerateMocks([TriviaRepo])
void main() {
  late GetConcreteTrivialUseCase useCase;
  final mockTriviaRepo = MockTriviaRepo();

  setUp(() {
    useCase = GetConcreteTrivialUseCase(mockTriviaRepo);
  });

  const int testNumber = 2;
  const testTrivialEntity = TriviaEntity(text: 'test text', number: testNumber);

  test(
    'should get trivia from the repository',
    () async {
      //arrange
      when(mockTriviaRepo.getConcreteTrivia(testNumber))
          .thenAnswer((realInvocation) async => const Right(testTrivialEntity));

      //act
      final result = await useCase(const Params(number: testNumber));

      //assert
      expect(result, const Right(testTrivialEntity));
      verify(mockTriviaRepo.getConcreteTrivia(testNumber));
      verifyNoMoreInteractions(mockTriviaRepo);
    },
  );
}


//  test('should ', () async {
//     //arrange

//     //act

//     //assert
//   });