import 'dart:convert';
import '../../../fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/features/trivial/data/models/trivia_model.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';

void main() {
  const testTrivialModel = TriviaModel(
    number: 1,
    text: 'This is another test text',
  );

  test('should be a sub class of the TrivialEntity', () {
    //assert
    expect(testTrivialModel, isA<TriviaEntity>());
  });

  group('fromJson', () {
    test('should return a valid model with int number', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('trivia_int.json'));

      // act
      final result = TriviaModel.fromJson(jsonMap);

      // assert
      expect(result, testTrivialModel);
    });

    test('should return a valid model with a double number passed', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('trivia_double.json'));

      // act
      final result = TriviaModel.fromJson(jsonMap);

      // assert
      expect(result, testTrivialModel);
    });
  });

  group('toJson', () {
    test('should return a json map', () {
      // arrange
      // act
      final result = testTrivialModel.toJson();

      // assert

      final expectedJsonMap = {
        'number': 1,
        'text': 'This is another test text',
      };

      expect(result, expectedJsonMap);
    });
  });
}
