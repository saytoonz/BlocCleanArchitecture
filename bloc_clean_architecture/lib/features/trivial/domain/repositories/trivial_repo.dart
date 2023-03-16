import '../entities/trivial.dart';
import 'package:either_dart/either.dart';
import '../../../../core/errors/app_error.dart';

abstract class TrivialRepo {
  Future<Either<AppError, TrivialEntity>> getConcreteTrivial(int number);
  Future<Either<AppError, TrivialEntity>> getRandomTrivial();
}
