import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'get_concrete_trivial_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivial.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivial_repo.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_random_trivia_use_case.dart';

@GenerateMocks([TrivialRepo])
void main() {
  late GetRandomTrivialUseCase useCase;
  final mockTrivialRepo = MockTrivialRepo();

  setUp(() {
    useCase = GetRandomTrivialUseCase(mockTrivialRepo);
  });

  const int testNumber = 2;
  const testTrivialEntity = TrivialEntity(text: 'text', number: testNumber);

  test(
    'should get trivial from the number repository',
    () async {
      //arrange
      when(mockTrivialRepo.getRandomTrivial())
          .thenAnswer((realInvocation) async => const Right(testTrivialEntity));

      //act
      final result = await useCase(NoParams());

      //assert
      expect(result, const Right(testTrivialEntity));
      verify(mockTrivialRepo.getRandomTrivial());
      verifyNoMoreInteractions(mockTrivialRepo);
    },
  );
}


//  test('should ', () async {
//     //arrange

//     //act

//     //assert
//   });