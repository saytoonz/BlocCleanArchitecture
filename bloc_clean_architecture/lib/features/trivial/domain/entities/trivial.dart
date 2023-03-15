import 'package:equatable/equatable.dart';

class TrivialEntity extends Equatable {
  final String text;
  final int number;

  const TrivialEntity({
    required this.text,
    required this.number,
  });

  @override
  List<Object?> get props => [text, number];
}
