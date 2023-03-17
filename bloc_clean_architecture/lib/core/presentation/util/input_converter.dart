import 'package:either_dart/either.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';

class InputConverter {
  Either<AppError, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends AppError {
  @override
  List<Object?> get props => [<dynamic>[]];
}
