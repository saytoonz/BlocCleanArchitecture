part of 'trivia_bloc_bloc.dart';

@immutable
abstract class TriviaBlocEvent extends Equatable {}

class GetTriviaForConcreteNumber extends TriviaBlocEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);

//----------------------------------------------------------------
  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomNumber extends TriviaBlocEvent {
  @override
  List<Object?> get props => [<dynamic>[]];
}
