import 'dart:convert';
import '../models/trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_clean_architecture/core/errors/exception.dart';

abstract class TriviaLocalDataSource {
  /// Gets the cached [TriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TriviaModel> getLastTrivia();

  Future<void> cacheTrivia(TriviaModel triviaToCache);
}

const cachedTrivialSharedPrefName = 'CACHED_TRIVIA';

class TriviaLocalDataSourceImpl implements TriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  TriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<TriviaModel> getLastTrivia() {
    String? jsonString =
        sharedPreferences.getString(cachedTrivialSharedPrefName);
    if (jsonString != null) {
      return Future.value(TriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTrivia(TriviaModel triviaToCache) {
    return sharedPreferences.setString(
      cachedTrivialSharedPrefName,
      json.encode(triviaToCache.toJson()),
    );
  }
}
