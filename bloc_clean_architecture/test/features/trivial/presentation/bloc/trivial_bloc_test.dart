import 'package:mockito/mockito.dart';
import 'trivial_bloc_test.mocks.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/core/presentation/util/input_converter.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';
import 'package:bloc_clean_architecture/features/trivial/presentation/bloc/trivia_bloc_bloc.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_random_trivia_use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/use_cases/get_concrete_trivial_use_case.dart';

@GenerateMocks([
  InputConverter,
  GetRandomTrivialUseCase,
  GetConcreteTrivialUseCase,
])
void main() {
  late TriviaBloc bloc;
  final getConcreteTrivialUseCase = MockGetConcreteTrivialUseCase();
  final getRandomTrivialUseCase = MockGetRandomTrivialUseCase();
  final mockInputConverter = MockInputConverter();

  setUp(() {
    bloc = TriviaBloc(
      concreteTrivialUseCase: getConcreteTrivialUseCase,
      randomTrivialUseCase: getRandomTrivialUseCase,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcrete', () {
    // The event takes in a String
    const testNumberString = '1';
    // This is the successful output of the InputConverter
    final testNumberParsed = int.parse(testNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = TriviaEntity(
      number: testNumberParsed,
      text: 'test trivia',
    );

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(testNumberParsed));

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(testNumberParsed));
        // act

        bloc.add(GetTriviaForConcrete(testNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(testNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcrete(testNumberString));
      },
    );

    // test(
    //   'should get data from the concrete use case',
    //   () async {
    //     // arrange
    //     when(mockInputConverter.stringToUnsignedInteger(any))
    //         .thenReturn(Right(testNumberParsed));
    //     when(getConcreteTrivialUseCase(any))
    //         .thenAnswer((_) async => Right(tNumberTrivia));
    //     // act
    //     bloc.add(GetTriviaForConcrete(testNumberString));
    //     await untilCalled(getConcreteTrivialUseCase(any));
    //     // assert
    //     verify(getConcreteTrivialUseCase(Params(number: testNumberParsed)));
    //   },
    // );

    // test(
    //   'should emit [Loading, Loaded] when data is gotten successfully',
    //   () async {
    //     // arrange
    //     setUpMockInputConverterSuccess();
    //     when(getConcreteTrivialUseCase(any))
    //         .thenAnswer((_) async => Right(tNumberTrivia));
    //     // assert later
    //     final expected = [
    //       Empty(),
    //       Loading(),
    //       Loaded(triviaEntity: tNumberTrivia),
    //     ];
    //     expectLater(bloc.state, emitsInOrder(expected));
    //     // act
    //     bloc.add(GetTriviaForConcrete(testNumberString));
    //   },
    // );

    // test(
    //   'should emit [Loading, Error] when getting data fails',
    //   () async {
    //     // arrange
    //     setUpMockInputConverterSuccess();
    //     when(getConcreteTrivialUseCase(any))
    //         .thenAnswer((_) async => Left(ServerError()));
    //     // assert later
    //     final expected = [
    //       Empty(),
    //       Loading(),
    //       Error(message: SERVER_FAILURE_MESSAGE),
    //     ];
    //     expectLater(bloc.state, emitsInOrder(expected));
    //     // act
    //     bloc.add(GetTriviaForConcrete(testNumberString));
    //   },
    // );

    // test(
    //   'should emit [Loading, Error] with a proper message for the error when getting data fails',
    //   () async {
    //     // arrange
    //     setUpMockInputConverterSuccess();
    //     when(getConcreteTrivialUseCase(any))
    //         .thenAnswer((_) async => Left(CacheError()));
    //     // assert later
    //     final expected = [
    //       Empty(),
    //       Loading(),
    //       Error(message: CACHE_FAILURE_MESSAGE),
    //     ];
    //     expectLater(bloc.state, emitsInOrder(expected));
    //     // act
    //     bloc.add(GetTriviaForConcrete(testNumberString));
    //   },
    // );
  });

  // group('GetTriviaForRandomNumber', () {
  //   const testTriviaEntity = TriviaEntity(number: 1, text: 'test trivia');

  //   test(
  //     'should get data from the random use case',
  //     () async {
  //       // arrange
  //       when(getRandomTrivialUseCase(any))
  //           .thenAnswer((_) async => const Right(testTriviaEntity));
  //       // act
  //       bloc.add(GetTriviaForRandom());
  //       await untilCalled(getRandomTrivialUseCase(any));
  //       // assert
  //       verify(getRandomTrivialUseCase(NoParams()));
  //     },
  //   );

  //   test(
  //     'should emit [Loading, Loaded] when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(getRandomTrivialUseCase(any))
  //           .thenAnswer((_) async => const Right(testTriviaEntity));
  //       // assert later
  //       final expected = [
  //         Empty(),
  //         Loading(),
  //         Loaded(triviaEntity: testTriviaEntity),
  //       ];
  //       expectLater(bloc.state, emitsInOrder(expected));
  //       // act
  //       bloc.add(GetTriviaForRandom());
  //     },
  //   );

  //   test(
  //     'should emit [Loading, Error] when getting data fails',
  //     () async {
  //       // arrange
  //       when(getRandomTrivialUseCase(any))
  //           .thenAnswer((_) async => Left(ServerError()));
  //       // assert later
  //       final expected = [
  //         Empty(),
  //         Loading(),
  //         Error(message: SERVER_FAILURE_MESSAGE),
  //       ];
  //       expectLater(bloc.state, emitsInOrder(expected));
  //       // act
  //       bloc.add(GetTriviaForRandom());
  //     },
  //   );

  //   test(
  //     'should emit [Loading, Error] with a proper message for the error when getting data fails',
  //     () async {
  //       // arrange
  //       when(getRandomTrivialUseCase(any))
  //           .thenAnswer((_) async => Left(CacheError()));
  //       // assert later
  //       final expected = [
  //         Empty(),
  //         Loading(),
  //         Error(message: CACHE_FAILURE_MESSAGE),
  //       ];
  //       expectLater(bloc.state, emitsInOrder(expected));
  //       // act
  //       bloc.add(GetTriviaForRandom());
  //     },
  //   );
  // });
}
