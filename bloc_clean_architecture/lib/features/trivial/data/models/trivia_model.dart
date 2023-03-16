import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';

class TriviaModel extends TriviaEntity {
  const TriviaModel({
    required text,
    required number,
  }) : super(text: text, number: number);

  factory TriviaModel.fromJson(Map<String, dynamic> map) => TriviaModel(
        text: map['text'],
        number: (map['number'] as num).toInt(),
      );

  toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
