import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'trivia_remote_data_source_test.mocks.dart';
import 'package:bloc_clean_architecture/core/errors/exception.dart';
import 'package:bloc_clean_architecture/features/trivial/data/models/trivia_model.dart';
import 'package:bloc_clean_architecture/features/trivial/data/data_sources/trivia_remote_data_source.dart';

@GenerateMocks([http.Client])
void main() {
  late TriviaRemoteDataSourceImpl dataSource;
  MockClient mockHttpClient = MockClient();

  setUp(() {
    dataSource = TriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('trivia_int.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    const int testNumber = 1;
    final testTriviaModel =
        TriviaModel.fromJson(jsonDecode(fixture('trivia_int.json')));

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getConcreteTrivia(testNumber);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('http://numbersapi.com/$testNumber'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getConcreteTrivia(testNumber);
        // assert
        expect(result, equals(testTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getConcreteTrivia;
        // assert
        expect(() => call(testNumber),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        TriviaModel.fromJson(json.decode(fixture('trivia_int.json')));

    test(
      'should preform a GET request on a URL with *random* endpoint with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRandomTrivia();
        // assert
        verify(mockHttpClient.get(
          Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRandomTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRandomTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
