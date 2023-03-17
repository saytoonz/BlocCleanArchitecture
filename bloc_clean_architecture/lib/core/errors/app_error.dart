import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {}

// General failures
class ServerError extends AppError {
  @override
  List<Object?> get props => [const <dynamic>[]];
}

class CacheError extends AppError {
  @override
  List<Object?> get props => [const <dynamic>[]];
}
