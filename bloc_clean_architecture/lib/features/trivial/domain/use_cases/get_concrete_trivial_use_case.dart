import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import '../repositories/trivial_repo.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/use_cases/use_case.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivial.dart';

class GetConcreteTrivialUseCase extends UseCase<TrivialEntity, Params> {
  final TrivialRepo trivialRepo;

  GetConcreteTrivialUseCase(this.trivialRepo);

  @override
  Future<Either<AppError, TrivialEntity>> call(Params params) async {
    return await trivialRepo.getConcreteTrivial(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
