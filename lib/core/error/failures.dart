import 'exceptions.dart';

/// Domain-level error returned to view models.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

Failure mapExceptionToFailure(Object error) {
  return switch (error) {
    NetworkException e => NetworkFailure(e.message),
    NotFoundException e => NotFoundFailure(e.message),
    ServerException e => ServerFailure(e.message),
    _ => UnknownFailure(error.toString()),
  };
}
