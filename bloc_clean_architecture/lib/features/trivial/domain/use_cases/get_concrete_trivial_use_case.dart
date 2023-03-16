import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import '../repositories/trivia_repo.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';

class GetConcreteTrivialUseCase extends UseCase<TriviaEntity, Params> {
  final TriviaRepo trivialRepo;

  GetConcreteTrivialUseCase(this.trivialRepo);

  @override
  Future<Either<AppError, TriviaEntity>> call(Params params) async {
    return await trivialRepo.getConcreteTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
