import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  const AppError([List properties = const <dynamic>[]]);
}

// General failures
class ServerError extends AppError {
  @override
  List<Object?> get props => [];
}

class CacheError extends AppError {
  @override
  List<Object?> get props => [];
}
