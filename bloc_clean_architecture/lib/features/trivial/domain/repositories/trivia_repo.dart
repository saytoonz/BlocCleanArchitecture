import '../entities/trivia_entity.dart';
import 'package:either_dart/either.dart';
import '../../../../core/errors/app_error.dart';

abstract class TriviaRepo {
  Future<Either<AppError, TriviaEntity>> getConcreteTrivia(int number);
  Future<Either<AppError, TriviaEntity>> getRandomTrivia();
}
