import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
