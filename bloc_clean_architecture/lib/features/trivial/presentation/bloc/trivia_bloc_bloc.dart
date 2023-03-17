import 'dart:async';
import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../domain/entities/trivia_entity.dart';
import '../../domain/use_cases/get_random_trivia_use_case.dart';
import '../../../../core/presentation/util/input_converter.dart';
import '../../domain/use_cases/get_concrete_trivial_use_case.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';

part 'trivia_bloc_event.dart';
part 'trivia_bloc_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class TriviaBloc extends Bloc<TriviaBlocEvent, TriviaBlocState> {
  final GetConcreteTrivialUseCase concreteTrivialUseCase;
  final GetRandomTrivialUseCase randomTrivialUseCase;
  final InputConverter inputConverter;

  TriviaBloc({
    required this.concreteTrivialUseCase,
    required this.randomTrivialUseCase,
    required this.inputConverter,
  }) : super(Empty());

  @override
  TriviaBlocState get initialState => Empty();

  @override
  Stream<TriviaBlocState> mapEventToState(
    TriviaBlocEvent event,
  ) async* {
    if (event is GetTriviaForConcrete) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await concreteTrivialUseCase(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandom) {
      yield Loading();
      final failureOrTrivia = await randomTrivialUseCase(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<TriviaBlocState> _eitherLoadedOrErrorState(
    Either<AppError, TriviaEntity> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(triviaEntity: trivia),
    );
  }

  String _mapFailureToMessage(AppError failure) {
    switch (failure.runtimeType) {
      case ServerError:
        return SERVER_FAILURE_MESSAGE;
      case CacheError:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
