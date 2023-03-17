import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'trivia_local_data_source_test.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_clean_architecture/core/errors/exception.dart';
import 'package:bloc_clean_architecture/features/trivial/data/models/trivia_model.dart';
import 'package:bloc_clean_architecture/features/trivial/data/data_sources/trivia_local_data_source.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late TriviaLocalDataSourceImpl dataSource;
  final mockSharedPreferences = MockSharedPreferences();

  setUp(() {
    dataSource = TriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final testTriviaModel =
        TriviaModel.fromJson(jsonDecode(fixture('trivia_cached.json')));

    test(
      'should return TriviaEntity from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await dataSource.getLastTrivia();
        // assert
        verify(mockSharedPreferences.getString(cachedTrivialSharedPrefName));
        expect(result, equals(testTriviaModel));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastTrivia;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const testTriviaModel = TriviaModel(
      number: 1,
      text: 'test trivia',
    );

    test('should call SharedPreferences to cache the data', () async {
      // act
      // await dataSource.cacheTrivia(testTriviaModel);
      // assert
      // final expectedJsonString = jsonEncode(testTriviaModel.toJson());

      // verify(
      //   mockSharedPreferences.setString(
      //     cachedTrivialSharedPrefName,
      //     expectedJsonString,
      //   ),
      // );
    });
  });
}
