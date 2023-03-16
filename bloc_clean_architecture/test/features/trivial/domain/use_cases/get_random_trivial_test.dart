import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'get_concrete_trivial_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivia_repo.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_random_trivia_use_case.dart';

@GenerateMocks([TriviaRepo])
void main() {
  late GetRandomTrivialUseCase useCase;
  final mockTriviaRepo = MockTriviaRepo();

  setUp(() {
    useCase = GetRandomTrivialUseCase(mockTriviaRepo);
  });

  const int testNumber = 2;
  const testTrivialEntity = TriviaEntity(text: 'text', number: testNumber);

  test(
    'should get trivial from the number repository',
    () async {
      //arrange
      when(mockTriviaRepo.getRandomTrivia())
          .thenAnswer((realInvocation) async => const Right(testTrivialEntity));

      //act
      final result = await useCase(NoParams());

      //assert
      expect(result, const Right(testTrivialEntity));
      verify(mockTriviaRepo.getRandomTrivia());
      verifyNoMoreInteractions(mockTriviaRepo);
    },
  );
}


//  test('should ', () async {
//     //arrange

//     //act

//     //assert
//   });