part of 'trivia_bloc_bloc.dart';

@immutable
abstract class TriviaBlocEvent extends Equatable {}

class GetTriviaForConcrete extends TriviaBlocEvent {
  final String numberString;

  GetTriviaForConcrete(this.numberString);

//----------------------------------------------------------------
  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandom extends TriviaBlocEvent {
  @override
  List<Object?> get props => [<dynamic>[]];
}
