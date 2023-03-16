import 'package:either_dart/either.dart';
import '../../../../core/errors/app_error.dart';
import '../../domain/entities/trivia_entity.dart';
import '../../domain/repositories/trivia_repo.dart';
import '../../../../core/platform/network_info.dart';
import '../data_sources/trivia_local_data_source.dart';
import '../data_sources/trivia_remote_data_source.dart';
import 'package:bloc_clean_architecture/core/errors/exception.dart';
import 'package:bloc_clean_architecture/features/trivial/data/models/trivia_model.dart';

typedef Future<TriviaModel> _ConcreteOrRandomChooser();

class TriviaRepoImpl extends TriviaRepo {
  final TriviaRemoteDataSource remoteDataSource;
  final TriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TriviaRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<AppError, TriviaEntity>> getConcreteTrivia(int number) async {
    return _getTrivia(() {
      return remoteDataSource.getConcreteTrivia(number);
    });
  }

  @override
  Future<Either<AppError, TriviaEntity>> getRandomTrivia() async {
    return _getTrivia(() {
      return remoteDataSource.getRandomTrivia();
    });
  }

  Future<Either<AppError, TriviaEntity>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        TriviaModel model = await getConcreteOrRandom();
        localDataSource.cacheTrivia(model);
        return Right(model);
      } on ServerException {
        return Left(ServerError());
      }
    } else {
      try {
        TriviaModel model = await localDataSource.getLastTrivia();
        return Right(model);
      } on CacheException {
        return Left(CacheError());
      }
    }
  }
}
