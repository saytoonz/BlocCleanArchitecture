import 'package:equatable/equatable.dart';

class TriviaEntity extends Equatable {
  final String text;
  final int number;

  const TriviaEntity({
    required this.text,
    required this.number,
  });

  @override
  List<Object?> get props => [text, number];
}
