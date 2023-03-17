part of 'trivia_bloc_bloc.dart';

@immutable
abstract class TriviaBlocState extends Equatable {}

class Empty extends TriviaBlocState {
  @override
  List<Object?> get props => [const <dynamic>[]];
}

////////////////////////////////
///When loading data
////////////////////////////////
class Loading extends TriviaBlocState {
  @override
  List<Object?> get props => [const <dynamic>[]];
}

////////////////////////////////
///When data is done loading
////////////////////////////////
class Loaded extends TriviaBlocState {
  final TriviaEntity triviaEntity;

  Loaded({required this.triviaEntity});

  @override
  List<Object?> get props => [triviaEntity];
}

////////////////////////////////////
///When was an error while loading data
////////////////////////////////////
class Error extends TriviaBlocState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
