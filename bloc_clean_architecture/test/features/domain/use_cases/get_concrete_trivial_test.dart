import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'get_random_trivial_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivial.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivial_repo.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_concrete_trivial_use_case.dart';

@GenerateMocks([TrivialRepo])
void main() {
  late GetConcreteTrivialUseCase useCase;
  final mockTrivialRepo = MockTrivialRepo();

  setUp(() {
    useCase = GetConcreteTrivialUseCase(mockTrivialRepo);
  });

  const int testNumber = 2;
  const testTrivialEntity =
      TrivialEntity(text: 'test text', number: testNumber);

  test(
    'should get trivia from the repository',
    () async {
      //arrange
      when(mockTrivialRepo.getConcreteTrivial(testNumber))
          .thenAnswer((realInvocation) async => const Right(testTrivialEntity));

      //act
      final result = await useCase(const Params(number: testNumber));

      //assert
      expect(result, const Right(testTrivialEntity));
      verify(mockTrivialRepo.getConcreteTrivial(testNumber));
      verifyNoMoreInteractions(mockTrivialRepo);
    },
  );
}


//  test('should ', () async {
//     //arrange

//     //act

//     //assert
//   });