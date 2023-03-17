import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'trivia_bloc_event.dart';
part 'trivia_bloc_state.dart';

class TriviaBlocBloc extends Bloc<TriviaBlocEvent, TriviaBlocState> {
  TriviaBlocBloc() : super(Empty()) {
    on<TriviaBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
