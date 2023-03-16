import 'package:either_dart/either.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivial.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/repositories/trivial_repo.dart';

class GetRandomTrivialUseCase extends UseCase<TrivialEntity, NoParams> {
  final TrivialRepo trivialRepo;

  GetRandomTrivialUseCase(this.trivialRepo);

  @override
  Future<Either<AppError, TrivialEntity>> call(NoParams params) async {
    return await trivialRepo.getRandomTrivial();
  }
}
