import 'package:either_dart/either.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivia_repo.dart';

class GetRandomTrivialUseCase extends UseCase<TriviaEntity, NoParams> {
  final TriviaRepo trivialRepo;

  GetRandomTrivialUseCase(this.trivialRepo);

  @override
  Future<Either<AppError, TriviaEntity>> call(NoParams params) async {
    return await trivialRepo.getRandomTrivia();
  }
}
