import 'dart:convert';
import '../models/trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_clean_architecture/core/errors/exception.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class TriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TriviaModel> getConcreteTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TriviaModel> getRandomTrivia();
}

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  final http.Client client;

  TriviaRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<TriviaModel> getConcreteTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<TriviaModel> getRandomTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<TriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
