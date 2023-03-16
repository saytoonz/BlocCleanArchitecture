import '../models/trivia_model.dart';

abstract class TriviaLocalDataSource {
  /// Gets the cached [TriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TriviaModel> getLastTrivia();

  Future<void> cacheTrivia(TriviaModel triviaToCache);
}
